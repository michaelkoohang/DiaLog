//
//  HomeA1CCard.swift
//  DiaLog
//
//  Created by Michael Koohang on 5/23/20.
//  Copyright © 2020 Koohang. All rights reserved.
//

import UIKit
import Lottie
import CoreData

class HomeA1CCard: HomeCard {
    
    init() {
        super.init(style: .default, reuseIdentifier: "ha1c")
        NotificationCenter.default.addObserver(self, selector:#selector(restartAnimation), name:
        UIApplication.willEnterForegroundNotification, object: nil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setup() {
        self.contentView.addSubview(lastLogLabel)
        self.contentView.addSubview(chevron)
        self.contentView.addSubview(lastLog)
        self.contentView.addSubview(units)
        self.contentView.addSubview(date)
        self.contentView.addSubview(time)
        self.contentView.addSubview(noDataLabel)
        self.contentView.addSubview(startLoggingLabel)
        self.contentView.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            lastLogLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            lastLogLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            
            chevron.centerYAnchor.constraint(equalTo: lastLogLabel.centerYAnchor, constant: 0),
            chevron.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            chevron.heightAnchor.constraint(equalToConstant: 20),
            chevron.widthAnchor.constraint(equalToConstant: 20),
            
            lastLog.topAnchor.constraint(equalTo: lastLogLabel.bottomAnchor, constant: 8),
            lastLog.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            lastLog.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),

            units.firstBaselineAnchor.constraint(equalTo: lastLog.firstBaselineAnchor, constant: 0),
            units.leftAnchor.constraint(equalTo: lastLog.rightAnchor, constant: 12),

            date.centerYAnchor.constraint(equalTo: lastLog.centerYAnchor, constant: -12),
            date.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            date.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant:-16),

            time.centerYAnchor.constraint(equalTo: lastLog.centerYAnchor, constant: 12),
            time.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            time.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),
            
            noDataLabel.centerYAnchor.constraint(equalTo: animationView.centerYAnchor, constant: -8),
            noDataLabel.leftAnchor.constraint(equalTo: self.animationView.rightAnchor, constant: 8),
            noDataLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),

            startLoggingLabel.centerYAnchor.constraint(equalTo: animationView.centerYAnchor, constant: 12),
            startLoggingLabel.leftAnchor.constraint(equalTo: self.animationView.rightAnchor, constant: 8),
            startLoggingLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            
            animationView.topAnchor.constraint(equalTo: lastLogLabel.bottomAnchor, constant: 12),
            animationView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            animationView.heightAnchor.constraint(equalToConstant: 60),
            animationView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        
    }
    
    // UI Components
    
    let lastLogLabel: UILabel = {
        let l = UILabel()
        l.text = "Last Log"
        l.textColor = .secondaryLabel
        l.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let chevron: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .tertiaryLabel
        iv.image = UIImage(systemName: "chevron.right")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let lastLog: UILabel = {
        let l = UILabel()
        l.text = "0.0"
        l.textColor = .systemGreen
        l.font = UIFont.systemFont(ofSize: 56, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let units: UILabel = {
        let l = UILabel()
        l.text = "%"
        l.textColor = .tertiaryLabel
        l.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let date: UILabel = {
        let l = UILabel()
        l.text = "No Data"
        l.textColor = .tertiaryLabel
        l.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let time: UILabel = {
        let l = UILabel()
        l.text = "No Data"
        l.textColor = .tertiaryLabel
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let noDataLabel: UILabel = {
        let l = UILabel()
        l.text = "No Logs"
        l.font = .systemFont(ofSize: 18, weight: .bold)
        l.textAlignment = .left
        l.textColor = .tertiaryLabel
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let startLoggingLabel: UILabel = {
        let l = UILabel()
        l.text = "Start logging to see your data."
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.textAlignment = .left
        l.textColor = .tertiaryLabel
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let animationView: AnimationView = {
        let a = AnimationView()
        a.animation = Animation.named("dots")
        a.contentMode = .scaleAspectFit
        a.loopMode = .loop
        a.translatesAutoresizingMaskIntoConstraints = false
        return a
    }()
    
    // Logic
    
    func configureCell() {
        updateA1C()
    }
    
    func updateA1C() {
        let result = DBHandler.getMostRecentA1C()
        
        if !result.isEmpty {
            let log = result[0]
            
            lastLog.isHidden = false
            units.isHidden = false
            date.isHidden = false
            time.isHidden = false
            animationView.isHidden = true
            noDataLabel.isHidden = true
            startLoggingLabel.isHidden = true
            animationView.pause()
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, yyyy"
            self.date.text = formatter.string(from: log.date!)
            formatter.dateFormat = "h:mm a"
            self.time.text = formatter.string(from: log.date!)
            self.lastLog.text = String(log.value)
        } else {
            lastLog.isHidden = true
            units.isHidden = true
            date.isHidden = true
            time.isHidden = true
            animationView.isHidden = false
            noDataLabel.isHidden = false
            startLoggingLabel.isHidden = false
            animationView.play()
        }
        
    }
    
    @objc func restartAnimation() {
        animationView.play()
    }
    
}
