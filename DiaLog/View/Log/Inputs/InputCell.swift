//
//  InputCell.swift
//  DiaLog
//
//  Created by Michael Koohang on 5/26/20.
//  Copyright © 2020 Koohang. All rights reserved.
//

import UIKit

class InputCell: UITableViewCell, UITextFieldDelegate {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "default")
        self.selectionStyle = .none
        self.backgroundColor = .secondarySystemGroupedBackground
        self.layer.cornerRadius = 10
        input.delegate = self
    }
    
    convenience init(iconTitle: String, placeholder: String, position: Int) {
        self.init()
        icon.image = UIImage(systemName: iconTitle)
        input.placeholder = placeholder
        if position == 0 {
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else if position == 1 {
            self.layer.cornerRadius = 0
        } else if position == 2 {
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        setup(position: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(position: Int) {
        self.contentView.addSubview(icon)
        self.contentView.addSubview(input)
        
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: self.input.centerYAnchor, constant: 0),
            icon.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            icon.widthAnchor.constraint(equalToConstant: 25),
            icon.heightAnchor.constraint(equalToConstant: 25),
            
            input.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            input.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            input.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 16),
            input.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        input.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        input.resignFirstResponder()
    }
    
    let icon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .tertiaryLabel
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var input: UITextField = {
        let t = UITextField()
        t.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        t.returnKeyType = .done
        t.borderStyle = .none
        t.clearButtonMode = .always
        t.autocorrectionType = .no
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
}
