//
//  ErrorView.swift
//  DiaLog
//
//  Created by Michael Koohang on 5/26/20.
//  Copyright © 2020 Koohang. All rights reserved.
//

import UIKit

class StatusView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemRed
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        setup()
    }
    
    convenience init(title: String, message: String, type: Status) {
        self.init()
        self.title.text = title
        self.message.text = message
        if type == .Error {
            self.backgroundColor = .systemRed
        }
        if type == .Success {
            self.backgroundColor = .systemGreen
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.addSubview(title)
        self.addSubview(message)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            
            message.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            message.leftAnchor.constraint(equalTo: title.leftAnchor, constant: 0),
            message.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
        ])
    }
    
    let title: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.font = .systemFont(ofSize: 24, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let message: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.font = .systemFont(ofSize: 14, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
}
