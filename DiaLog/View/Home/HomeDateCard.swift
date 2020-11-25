//
//  HomeDateCell.swift
//  DiaLog
//
//  Created by Michael Koohang on 5/23/20.
//  Copyright © 2020 Koohang. All rights reserved.
//

import UIKit

class HomeDateCard: HomeCard {

    init() {
        super.init(style: .default, reuseIdentifier: "hdc")
        NotificationCenter.default.addObserver(self, selector:#selector(rotate), name:
            UIApplication.willEnterForegroundNotification, object: nil)
        setup()
        setDate()
        rotate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        self.addSubview(icon)
        self.addSubview(dayLabel)
        self.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            icon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            icon.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            icon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -18),
            icon.heightAnchor.constraint(equalToConstant: 45),
            icon.widthAnchor.constraint(equalToConstant: 45),
            
            dayLabel.centerYAnchor.constraint(equalTo: self.icon.centerYAnchor, constant: -14),
            dayLabel.leftAnchor.constraint(equalTo: self.icon.rightAnchor, constant: 16),
            dateLabel.centerYAnchor.constraint(equalTo: self.icon.centerYAnchor, constant: 14),
            dateLabel.leftAnchor.constraint(equalTo: self.icon.rightAnchor, constant: 16)
        ])
        
    }
    
    // UI Components
    
    let icon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "Logo.png")
        iv.backgroundColor = UIColor(white: 0, alpha: 0)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let dayLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        l.textColor = .label
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let dateLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        l.textColor = .secondaryLabel
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    // Logic
    
    func setDate() {
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "EEEE"
        dayLabel.text = formatter.string(from: date)
        
        formatter.dateFormat = "MMMM dd, yyyy"
        dateLabel.text = formatter.string(from: date)
    }
    
    @objc func rotate() {
        if icon.layer.animation(forKey: "rotate") == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = -Float.pi * 2.0
            rotationAnimation.duration = 8
            rotationAnimation.repeatCount = Float.infinity
            
            icon.layer.add(rotationAnimation, forKey: "rotate")
        }
    }

}
