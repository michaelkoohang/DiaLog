//
//  HomeFootCheckCard.swift
//  DiaLog
//
//  Created by Michael Koohang on 5/23/20.
//  Copyright © 2020 Koohang. All rights reserved.
//

import UIKit
import Lottie
import CoreData

class HomeFootCheckCard: HomeCard {
    
    var photoHeight: NSLayoutConstraint?
    
    init() {
        super.init(style: .default, reuseIdentifier: "hfcc")
        NotificationCenter.default.addObserver(self, selector:#selector(restartAnimation), name:
            UIApplication.willEnterForegroundNotification, object: nil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        self.contentView.addSubview(lastFootCheckLabel)
        self.contentView.addSubview(chevron)
        self.contentView.addSubview(photo)
        dateView.addSubview(photoDate)
        dateView.addSubview(photoTime)
        self.contentView.addSubview(dateView)
        self.contentView.addSubview(noDataLabel)
        self.contentView.addSubview(startLoggingLabel)
        self.contentView.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            lastFootCheckLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            lastFootCheckLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            
            chevron.centerYAnchor.constraint(equalTo: lastFootCheckLabel.centerYAnchor, constant: 0),
            chevron.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            chevron.heightAnchor.constraint(equalToConstant: 20),
            chevron.widthAnchor.constraint(equalToConstant: 20),
            
            photo.topAnchor.constraint(equalTo: lastFootCheckLabel.bottomAnchor, constant: 16),
            photo.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            photo.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            photo.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            
            dateView.bottomAnchor.constraint(equalTo: photo.bottomAnchor, constant: -12),
            dateView.leftAnchor.constraint(equalTo: photo.leftAnchor, constant: 12),
            dateView.rightAnchor.constraint(equalTo: photo.rightAnchor, constant: -12),
            dateView.heightAnchor.constraint(equalToConstant: 40),
            
            photoDate.centerYAnchor.constraint(equalTo: dateView.centerYAnchor, constant: 0),
            photoDate.leftAnchor.constraint(equalTo: dateView.leftAnchor, constant: 12),
            
            photoTime.centerYAnchor.constraint(equalTo: dateView.centerYAnchor, constant: 0),
            photoTime.rightAnchor.constraint(equalTo: dateView.rightAnchor, constant: -12),
            
            noDataLabel.centerYAnchor.constraint(equalTo: animationView.centerYAnchor, constant: -8),
            noDataLabel.leftAnchor.constraint(equalTo: self.animationView.rightAnchor, constant: 8),
            noDataLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            
            startLoggingLabel.centerYAnchor.constraint(equalTo: animationView.centerYAnchor, constant: 12),
            startLoggingLabel.leftAnchor.constraint(equalTo: self.animationView.rightAnchor, constant: 8),
            startLoggingLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            
            animationView.topAnchor.constraint(equalTo: lastFootCheckLabel.bottomAnchor, constant: 12),
            animationView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            animationView.heightAnchor.constraint(equalToConstant: 60),
            animationView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        photoHeight = photo.heightAnchor.constraint(equalToConstant: 400)
        photoHeight?.isActive = true
    }
    
    // UI Components
    
    let lastFootCheckLabel: UILabel = {
        let l = UILabel()
        l.text = "Last Foot Check"
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
    
    let photo: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "no-photo.png")
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let dateView: UIView = {
        let v = UIView()
        v.backgroundColor = .secondarySystemGroupedBackground
        v.layer.cornerRadius = 10
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let photoDate: UILabel = {
        let l = UILabel()
        l.textColor = .tertiaryLabel
        l.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let photoTime: UILabel = {
        let l = UILabel()
        l.textColor = .tertiaryLabel
        l.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let noDataLabel: UILabel = {
        let l = UILabel()
        l.text = "No Foot Checks"
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
        a.animation = Animation.named("camera")
        a.contentMode = .scaleAspectFit
        a.loopMode = .loop
        a.translatesAutoresizingMaskIntoConstraints = false
        return a
    }()
    
    // Logic
    
    func configureCell() {
        updateFootCheck()
    }
    
    func updateFootCheck() {
        let result = DBHandler.getMostRecentFootCheck()
        let formatter = DateFormatter()

        if !result.isEmpty {
            let footCheck = result[0]
            formatter.dateFormat = "MMM dd, yyyy"
            
            self.photo.image = UIImage(data: footCheck.image!)
            self.photoDate.isHidden = false
            self.photoDate.text = formatter.string(from: footCheck.date!)
            formatter.dateFormat = "h:mm a"
            self.photoTime.isHidden = false
            self.photoTime.text = formatter.string(from: footCheck.date!)
            
            photo.isHidden = false
            photoDate.isHidden = false
            photoTime.isHidden = false
            animationView.isHidden = true
            noDataLabel.isHidden = true
            startLoggingLabel.isHidden = true
            animationView.pause()
            photoHeight?.constant = 400
            
        } else {
            formatter.dateFormat = "MMM dd, yyyy"
            
            photo.isHidden = true
            photoDate.isHidden = true
            photoTime.isHidden = true
            animationView.isHidden = false
            noDataLabel.isHidden = false
            startLoggingLabel.isHidden = false
            animationView.play()
            photoHeight?.constant = 55
        }
    }
    
    @objc func restartAnimation() {
        animationView.play()
    }
    
}
