//
//  AddA1CVC.swift
//  DiaLog
//
//  Created by Michael on 3/18/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit
import AVFoundation

class AddA1CVC: UIViewController {

    var dingSound: AVAudioPlayer?
    var callbackClosure: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        callbackClosure?()
    }
    
    func setup() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(titleUnderline)
        self.view.addSubview(amountTextField)
        self.view.addSubview(saveButton)
        self.view.addSubview(cancelButton)
        
        titleLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 28).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 28).isActive = true
        
        amountTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25).isActive = true
        amountTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 24).isActive = true
        amountTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -24).isActive = true
        amountTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        saveButton.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 28).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -50).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        cancelButton.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 28).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 50).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
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
        l.text = "A1C Log"
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
        t.keyboardType = .decimalPad
        t.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        t.textColor = UIColor(red: 61/255, green: 237/255, blue: 87/255, alpha: 1)
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
        if amountTextField.hasText {
            let amount = Double(amountTextField.text!)
            if (amount! >= 4.0 && amount! <= 15.0) {
                                
                let a1c = A1C(context: PersistanceService.context)
                a1c.value = amount!
                a1c.date = Date()
                PersistanceService.saveContext()
                
                amountTextField.resignFirstResponder()
                dingSound!.play()
                let alert = UIAlertController(title: "Success!", message: "Your A1C log has been saved.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "The value you entered is not within the valid range (4.0-15.0).", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter a value before submitting.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func done() {
        amountTextField.resignFirstResponder()
    }
    
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
