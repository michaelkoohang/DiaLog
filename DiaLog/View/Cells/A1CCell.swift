//
//  A1CCell.swift
//  DiaLog
//
//  Created by Michael on 7/25/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit

class A1CCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "a1c")
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        self.addSubview(log)
        self.addSubview(units)
        self.addSubview(date)
        self.addSubview(time)
        
        log.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        log.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        
        units.lastBaselineAnchor.constraint(equalTo: log.lastBaselineAnchor, constant: 0).isActive = true
        units.leftAnchor.constraint(equalTo: log.rightAnchor, constant: 8).isActive = true
        
        date.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -12).isActive = true
        date.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        
        time.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 12).isActive = true
        time.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
    }
    
    // UI Components
    
    let log: UILabel = {
        let l = UILabel()
        l.textColor = .systemGreen
        l.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let units: UILabel = {
        let l = UILabel()
        l.text = "%"
        l.textColor = .tertiaryLabel
        l.font = UIFont.systemFont(ofSize: 24, weight: .light)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let date: UILabel = {
        let l = UILabel()
        l.textColor = .label
        l.font = UIFont.systemFont(ofSize: 16, weight: .light)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let time: UILabel = {
        let l = UILabel()
        l.textColor = .secondaryLabel
        l.font = UIFont.systemFont(ofSize: 16, weight: .light)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    // Logic
    
    func configureCell(a1c: A1C) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        self.log.text = String(a1c.value)
        self.date.text = formatter.string(from: a1c.date!)
        formatter.dateFormat = "h:mm a"
        self.time.text = formatter.string(from: a1c.date!)
    }
    
}
