//
//  InputLongCell.swift
//  DiaLog
//
//  Created by Michael Koohang on 5/26/20.
//  Copyright © 2020 Koohang. All rights reserved.
//

import UIKit

class InputLongCell: UITableViewCell, UITextViewDelegate {
    
    var placeholderText: String?
    
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
        input.text = placeholder
        placeholderText = placeholder
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
            icon.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            icon.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            icon.widthAnchor.constraint(equalToConstant: 25),
            icon.heightAnchor.constraint(equalToConstant: 25),
            
            input.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 18),
            input.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            input.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 16),
            input.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
        ])
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if input.textColor == .tertiaryLabel {
            input.text = nil
            input.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if input.text.isEmpty {
            input.text = placeholderText
            input.textColor = .tertiaryLabel
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            input.resignFirstResponder()
            return false
        }
        
        return true
    }
        
    let icon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .tertiaryLabel
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let input: UITextView = {
        let t = UITextView()
        t.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        t.textContainer.lineFragmentPadding = 0
        t.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        t.textColor = .tertiaryLabel
        t.returnKeyType = .done
        t.autocorrectionType = .no
        t.backgroundColor = .secondarySystemGroupedBackground
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
}
