//
//  BloodSugarCell.swift
//  DiaLog
//
//  Created by Michael on 7/25/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit

class BloodSugarCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "bloodSugar")
        self.contentView.backgroundColor = .systemBackground
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        self.addSubview(log)
        self.addSubview(units)
        self.addSubview(date)
        self.addSubview(notes)
        
        NSLayoutConstraint.activate([
            log.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            log.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            
            units.lastBaselineAnchor.constraint(equalTo: log.lastBaselineAnchor, constant: 0),
            units.leftAnchor.constraint(equalTo: log.rightAnchor, constant: 8),
            
            date.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -12),
            date.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            
            notes.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 12),
            notes.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)
        ])
        
        
    }
    
    // UI Components
    
    let log: UILabel = {
        let l = UILabel()
        l.textColor = .systemRed
        l.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let units: UILabel = {
        let l = UILabel()
        l.text = "mg / dL"
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
    
    let notes: UILabel = {
        let l = UILabel()
        l.textColor = .secondaryLabel
        l.font = UIFont.systemFont(ofSize: 16, weight: .light)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    // Logic
    
    func configureCell(bloodSugar: BloodSugar) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        self.log.text = String(bloodSugar.value)
        self.date.text = formatter.string(from: bloodSugar.date!)
        self.notes.text = bloodSugar.type
    }

}
