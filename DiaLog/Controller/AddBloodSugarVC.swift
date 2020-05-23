//
//  AddBloodSugarVC.swift
//  DiaLog
//
//  Created by Michael on 3/14/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit
import DropDown
import AVFoundation

class AddBloodSugarVC: UIViewController {
    
    var dingSound: AVAudioPlayer?
    var callbackClosure: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        optionButton.addTarget(self, action: #selector(showOptions), for: .touchUpInside)
        setup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        callbackClosure?()
    }
    
    func setup() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(titleUnderline)
        self.view.addSubview(amountTextField)
        self.view.addSubview(dropdownView)
        self.view.addSubview(optionButton)
        self.view.addSubview(saveButton)
        self.view.addSubview(cancelButton)
        
        titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 28).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 28).isActive = true
        
        amountTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25).isActive = true
        amountTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 24).isActive = true
        amountTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -24).isActive = true
        amountTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        dropdownView.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 16).isActive = true
        dropdownView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 24).isActive = true
        dropdownView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -24).isActive = true
        dropdownView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        optionButton.centerYAnchor.constraint(equalTo: dropdownView.centerYAnchor, constant: 0).isActive = true
        optionButton.leftAnchor.constraint(equalTo: dropdownView.leftAnchor, constant: 18).isActive = true
        
        saveButton.topAnchor.constraint(equalTo: dropdownView.bottomAnchor, constant: 28).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -50).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        cancelButton.topAnchor.constraint(equalTo: dropdownView.bottomAnchor, constant: 28).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 50).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 70).isActive = true

        self.dropDown.anchorView = dropdownView
        dropDown.selectionAction = { (index: Int, item: String) in
            self.optionButton.setTitle(item, for: .normal)
        }
        
        let url = Bundle.main.url(forResource: "ding", withExtension: "aif")
        do {
            dingSound = try AVAudioPlayer(contentsOf: url!)
        } catch {
            print("error")
        }
    }
    
    // UI Components
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Blood Sugar Log"
        l.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let titleUnderline: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        v.layer.cornerRadius = 5
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let amountTextField: TextFieldView = {
        var t = TextFieldView()
        t.placeholder = "Amount"
        t.borderStyle = .none
        t.keyboardType = .numberPad
        t.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        t.textColor = UIColor(red: 231/255, green: 60/255, blue: 90/255, alpha: 1)
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()

    let dropDown: DropDown = {
        let dd = DropDown()
        dd.dataSource = ["Before Breakfast", "After Breakfast", "Before Lunch", "After Lunch", "Before Dinner", "After Dinner"]
        dd.dismissMode = .onTap
        dd.textFont = UIFont.systemFont(ofSize: 18, weight: .medium)
        dd.textColor = .black
        dd.backgroundColor = .white
        dd.selectedTextColor = .white
        dd.selectionBackgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        dd.separatorColor = .gray
        dd.cornerRadius = 20
        dd.cellHeight = 50
        dd.dimmedBackgroundColor = UIColor.white
        return dd
    }()
    
    let dropdownView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.shadowRadius = 4
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOffset = CGSize(width: 0, height: 0)
        v.layer.shadowOpacity = 0.1
        v.layer.cornerRadius = 10
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let optionButton: UIButton = {
        let b = UIButton()
        b.setTitle("Choose", for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        b.setTitleColor(UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1), for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let saveButton: UIButton = {
        var b = UIButton()
        b.setImage(UIImage(named: "confirm.png"), for: .normal)
        b.addTarget(self, action: #selector(save), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let cancelButton: UIButton = {
        var b = UIButton()
        b.setImage(UIImage(named: "cancel.png"), for: .normal)
        b.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    // Logic
    
    @objc func save() {
        if amountTextField.hasText && optionButton.titleLabel?.text != "Choose" {
            let amount = Int(amountTextField.text!)
            if (amount! >= 30 && amount! <= 500) {
                
                let value = Int16(amountTextField.text!)!
                let type = optionButton.titleLabel?.text
                let date = Date()
                
                let bs = BloodSugar(context: PersistanceService.context)
                bs.value = value
                bs.type = type
                bs.date = date
                PersistanceService.saveContext()
                
                amountTextField.resignFirstResponder()
                dingSound!.play()
                let alert = UIAlertController(title: "Success!", message: "Your blood sugar log has been saved.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "The value you entered is not within the valid range (30-500).", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter a value and choose an option before submitting.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func showOptions() {
        amountTextField.resignFirstResponder()
        dropDown.show()
    }

}
