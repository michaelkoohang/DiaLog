//
//  A1CView.swift
//  DiaLog
//
//  Created by Michael on 7/8/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit

class A1CView: CardView {

    override init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        self.addSubview(title)
        self.addSubview(mostRecentLogLabel)
        self.addSubview(mostRecentLog)
        self.addSubview(units)
        self.addSubview(date)
        self.addSubview(time)
        
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        
        mostRecentLogLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16).isActive = true
        mostRecentLogLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        
        mostRecentLog.topAnchor.constraint(equalTo: mostRecentLogLabel.bottomAnchor, constant: 8).isActive = true
        mostRecentLog.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        
        units.lastBaselineAnchor.constraint(equalTo: mostRecentLog.lastBaselineAnchor, constant: 0).isActive = true
        units.leftAnchor.constraint(equalTo: mostRecentLog.rightAnchor, constant: 12).isActive = true
        
        date.centerYAnchor.constraint(equalTo: mostRecentLog.centerYAnchor, constant: -14).isActive = true
        date.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        
        time.centerYAnchor.constraint(equalTo: mostRecentLog.centerYAnchor, constant: 14).isActive = true
        time.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
    }
    
    // UI Components
    
    let title: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        l.text = "A1C"
        l.textColor = .systemGreen
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let mostRecentLogLabel: UILabel = {
        let l = UILabel()
        l.text = "Most Recent Log"
        l.textColor = .secondaryLabel
        l.font = UIFont.systemFont(ofSize: 18, weight: .light)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    let mostRecentLog: UILabel = {
        let l = UILabel()
        l.text = "0.0"
        l.textColor = .systemGreen
        l.font = UIFont.systemFont(ofSize: 64, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let units: UILabel = {
        let l = UILabel()
        l.text = "%"
        l.textColor = .tertiaryLabel
        l.font = UIFont.systemFont(ofSize: 32, weight: .light)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let date: UILabel = {
        let l = UILabel()
        l.text = "No Data"
        l.textColor = .label
        l.font = UIFont.systemFont(ofSize: 18, weight: .light)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let time: UILabel = {
        let l = UILabel()
        l.text = "No Data"
        l.textColor = .secondaryLabel
        l.font = UIFont.systemFont(ofSize: 18, weight: .light)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    // Logic

    func setMostRecentA1C(log: A1C) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        self.date.text = formatter.string(from: log.date!)
        formatter.dateFormat = "h:mm a"
        self.time.text = formatter.string(from: log.date!)
        self.mostRecentLog.text = String(log.value)
    }
    
}
