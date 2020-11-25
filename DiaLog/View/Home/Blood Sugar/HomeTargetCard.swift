//
//  HomeBloodSugarCell.swift
//  DiaLog
//
//  Created by Michael Koohang on 5/23/20.
//  Copyright © 2020 Koohang. All rights reserved.
//

import UIKit
import CoreData

class HomeTargetCard: HomeCard, UITextFieldDelegate {
    
    let selectionFeedback = UISelectionFeedbackGenerator()
    let notficationFeedback = UINotificationFeedbackGenerator()
        
    init() {
        super.init(style: .default, reuseIdentifier: "hbsc")
        targetGoalTextField.delegate = self
        editButton.addTarget(self, action: #selector(toggleEdit), for: .touchUpInside)
        targetGoalTextField.text = DBHandler.getTargetBloodSugar()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        self.contentView.addSubview(targetGoalTitle)
        self.contentView.addSubview(editButton)
        self.contentView.addSubview(targetGoalTextField)
        self.contentView.addSubview(units)
        
        NSLayoutConstraint.activate([
            targetGoalTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            targetGoalTitle.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            editButton.centerYAnchor.constraint(equalTo: targetGoalTitle.centerYAnchor, constant: 0),
            editButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            editButton.heightAnchor.constraint(equalToConstant: 30),
            targetGoalTextField.topAnchor.constraint(equalTo: targetGoalTitle.bottomAnchor, constant: 4),
            targetGoalTextField.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            units.lastBaselineAnchor.constraint(equalTo: targetGoalTextField.lastBaselineAnchor, constant: 0),
            units.leftAnchor.constraint(equalTo: targetGoalTextField.rightAnchor, constant: 12),
            units.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        ])
    }
    
    // UI Components
    
    let title: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        l.textColor = .systemRed
        l.text = "Blood Sugar"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let targetGoalTitle: UILabel = {
        let l = UILabel()
        l.text = "Target"
        l.textColor = .secondaryLabel
        l.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let editButton: UIButton = {
        let b = UIButton()
        b.setTitle("Edit", for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        b.setTitleColor(.systemBlue, for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let targetGoalPicker: UIPickerView = {
        var p = UIPickerView()
        return p
    }()
    
    let targetGoalTextField: UITextField = {
        let l = UITextField()
        l.text = "0"
        l.textColor = .systemRed
        l.font = UIFont.systemFont(ofSize: 56, weight: .bold)
        l.keyboardType = .numberPad
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let units: UILabel = {
        let l = UILabel()
        l.text = "mg / dL"
        l.textColor = .tertiaryLabel
        l.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    
    // Logic
    
    func updateTarget() {
        targetGoalTextField.text = DBHandler.getTargetBloodSugar()
    }
    
    func configureCell() {
        updateTarget()
    }
    
    @objc func toggleEdit() {
        if targetGoalTextField.isFirstResponder {
            editButton.setTitle("Edit", for: .normal)
            targetGoalTextField.resignFirstResponder()
            notficationFeedback.notificationOccurred(.success)
            save()
        } else {
            editButton.setTitle("Done", for: .normal)
            targetGoalTextField.becomeFirstResponder()
            selectionFeedback.selectionChanged()
        }
    }
    
    @objc func save() {
        guard let amount = Int(targetGoalTextField.text!) else {
            targetGoalTextField.text = DBHandler.getTargetBloodSugar()
            return
        }
        
        DBHandler.deleteTargetBloodSugar()
        
        let value = Int16(amount)
        let type = "Target"
        let date = Date()
        
        let bs = BloodSugar(context: PersistanceService.context)
        bs.value = value
        bs.type = type
        bs.date = date
        PersistanceService.saveContext()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = targetGoalTextField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= 3
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        editButton.setTitle("Done", for: .normal)
    }
    
}
