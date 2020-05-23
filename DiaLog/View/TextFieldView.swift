//
//  TextFieldView.swift
//  DiaLog
//
//  Created by Michael on 10/4/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit

class TextFieldView: UITextField {
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.backgroundColor = .white
        self.layer.shadowRadius = 4
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.1
        self.layer.cornerRadius = 10
        
        let toolbar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.sizeToFit()
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        self.inputAccessoryView = toolbar
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        self.leftView = paddingView
        self.rightView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
        self.rightViewMode = UITextField.ViewMode.always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func done() {
        self.resignFirstResponder()
    }
    
}
