//
//  DateView.swift
//  DiaLog
//
//  Created by Michael on 7/8/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit

class DateView: CardView {
    
    override init() {
        super.init()
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 20
        self.translatesAutoresizingMaskIntoConstraints = false
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
        
        icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        icon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 65).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 65).isActive = true
        
        dayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -14).isActive = true
        dayLabel.leftAnchor.constraint(equalTo: self.icon.rightAnchor, constant: 8).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 14).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: self.icon.rightAnchor, constant: 8).isActive = true
    }
    
    // UI Components
    
    let icon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "icon.png")
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
        l.font = UIFont.systemFont(ofSize: 24, weight: .bold)
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
