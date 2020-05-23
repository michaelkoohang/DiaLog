//
//  EditTargetBloodSugarVC.swift
//  DiaLog
//
//  Created by Michael on 10/5/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class EditTargetBloodSugarVC: UIViewController {

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
        self.view.addSubview(logButton)
        self.view.addSubview(cancelButton)
        
        titleLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 28).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 28).isActive = true
        
        amountTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24).isActive = true
        amountTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 24).isActive = true
        amountTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -24).isActive = true
        amountTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        logButton.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 28).isActive = true
        logButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -50).isActive = true
        logButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        logButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
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
        l.text = "Target Blood Sugar"
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
    
    let logButton: UIButton = {
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
            let amount = Int(amountTextField.text!)
            if amount! >= 30 && amount! <= 500 {
                
                deleteTarget()
                
                let value = Int16(amountTextField.text!)!
                let type = "Target"
                let date = Date()
                
                let bs = BloodSugar(context: PersistanceService.context)
                bs.value = value
                bs.type = type
                bs.date = date
                PersistanceService.saveContext()
                
                amountTextField.resignFirstResponder()
                dingSound!.play()
                let alert = UIAlertController(title: "Success!", message: "Your target blood sugar has been updated.", preferredStyle: .alert)
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
            let alert = UIAlertController(title: "Error", message: "Please enter a value before saving.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func deleteTarget() {
        let fetchRequest: NSFetchRequest<BloodSugar> = BloodSugar.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "type == %@", "Target")
        do {
            let result = try PersistanceService.context.fetch(fetchRequest)
            if !result.isEmpty {
                PersistanceService.context.delete(result[0])
            }
        } catch {
            print("error")
        }
    }
    
    @objc func done() {
        amountTextField.resignFirstResponder()
    }
    
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }

}
