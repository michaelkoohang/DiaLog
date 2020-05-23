//
//  AddMedicationVC.swift
//  DiaLog
//
//  Created by Michael on 3/18/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit
import DropDown
import AVFoundation

class AddMedicationVC: UIViewController {
    
    var dingSound: AVAudioPlayer?
    var callbackClosure: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Medication"
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.unitsButton.addTarget(self, action: #selector(showUnits), for: .touchUpInside)
        self.frequencyButton.addTarget(self, action: #selector(showFrequencies), for: .touchUpInside)
        setup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        callbackClosure?()
    }
    
    func setup() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(titleUnderline)
        self.view.addSubview(nameTextField)
        self.view.addSubview(dosageTextField)
        self.view.addSubview(unitsDropDownView)
        self.view.addSubview(unitsButton)
        self.view.addSubview(frequencyDropDownView)
        self.view.addSubview(frequencyButton)
        self.view.addSubview(notesTextField)
        self.view.addSubview(saveButton)
        self.view.addSubview(cancelButton)
        
        titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 28).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 28).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 25).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        dosageTextField.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: 16).isActive = true
        dosageTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true
        dosageTextField.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -8).isActive = true
        dosageTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        unitsDropDownView.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: 16).isActive = true
        unitsDropDownView.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 8).isActive = true
        unitsDropDownView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true
        unitsDropDownView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        unitsButton.centerYAnchor.constraint(equalTo: unitsDropDownView.centerYAnchor, constant: 0).isActive = true
        unitsButton.leadingAnchor.constraint(equalTo: unitsDropDownView.leadingAnchor, constant: 18).isActive = true
        
        frequencyDropDownView.topAnchor.constraint(equalTo: self.dosageTextField.bottomAnchor, constant: 16).isActive = true
        frequencyDropDownView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true
        frequencyDropDownView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true
        frequencyDropDownView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        frequencyButton.centerYAnchor.constraint(equalTo: frequencyDropDownView.centerYAnchor, constant: 0).isActive = true
        frequencyButton.leadingAnchor.constraint(equalTo: frequencyDropDownView.leadingAnchor, constant: 18).isActive = true
        
        notesTextField.topAnchor.constraint(equalTo: self.frequencyDropDownView.bottomAnchor, constant: 16).isActive = true
        notesTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true
        notesTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true
        notesTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        saveButton.topAnchor.constraint(equalTo: notesTextField.bottomAnchor, constant: 28).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -50).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        cancelButton.topAnchor.constraint(equalTo: notesTextField.bottomAnchor, constant: 28).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 50).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.unitsDropDown.anchorView = unitsDropDownView
        unitsDropDown.selectionAction = { (index: Int, item: String) in
            self.unitsButton.setTitle(item, for: .normal)
        }
        
        self.frequencyDropDown.anchorView = frequencyDropDownView
        frequencyDropDown.selectionAction = { (index: Int, item: String) in
            self.frequencyButton.setTitle(item, for: .normal)
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
        l.text = "Add Medication"
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
    
    let nameTextField: TextFieldView = {
        var t = TextFieldView()
        t.placeholder = "Name"
        t.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        t.returnKeyType = .done       
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    let dosageTextField: TextFieldView = {
        var t = TextFieldView()
        t.placeholder = "Dosage"
        t.returnKeyType = .done
        t.keyboardType = .numberPad
        t.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    let unitsButton: UIButton = {
        let b = UIButton()
        b.setTitle("mg", for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        b.setTitleColor(UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1), for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let unitsDropDownView: UIView = {
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
    
    let unitsDropDown: DropDown = {
        let dd = DropDown()
        dd.dataSource = ["mg", "g", "units", "mL", "mcg"]
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
    
    let frequencyButton: UIButton = {
        let b = UIButton()
        b.setTitle("Frequency", for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        b.setTitleColor(UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1), for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let frequencyDropDownView: UIView = {
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
    
    let frequencyDropDown: DropDown = {
        let dd = DropDown()
        dd.dataSource = ["once a day", "twice a day", "three times a day", "once a week", "once a month"]
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
    
    let notesTextField: TextFieldView = {
        var t = TextFieldView()
        t.placeholder = "Notes"
        t.returnKeyType = .done
        t.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
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
        if nameTextField.hasText {
            if dosageTextField.hasText {
                if !(unitsButton.titleLabel?.text!.isEmpty)! {
                    if !(frequencyButton.titleLabel?.text!.isEmpty)! && frequencyButton.titleLabel?.text != "Frequency"  {
                        
                        let medication = Medication(context: PersistanceService.context)
                        medication.name = nameTextField.text
                        medication.dosage = Int16(dosageTextField.text!)!
                        medication.units = unitsButton.titleLabel?.text
                        medication.frequency = frequencyButton.titleLabel!.text
                        medication.notes = notesTextField.text
                        
                        PersistanceService.saveContext()
                        dingSound!.play()
                        let alert = UIAlertController(title: "Success!", message: "Your medication has been saved.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                            self.dismiss(animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true, completion: nil)                        
                    } else {
                        let alert = UIAlertController(title: "Error", message: "Please choose a frequency for your medication.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    let alert = UIAlertController(title: "Error", message: "Please choose units for your medication.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Error", message: "Please enter a dosage for your medication.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter a name for your medication.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func showUnits() {
        unitsDropDown.show()
    }
    
    @objc func showFrequencies() {
        frequencyDropDown.show()
    }
    
    func makeNumber() -> CGFloat {
        return CGFloat(Double(arc4random_uniform(255)) / 255.0)
    }

}
