//
//  FootCheckView.swift
//  DiaLog
//
//  Created by Michael on 7/8/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit
import CoreData

class FootCheckView: CardView {

    override init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        self.addSubview(title)
        self.addSubview(mostRecentFootCheckLabel)
        self.addSubview(photo)
        dateView.addSubview(photoDate)
        dateView.addSubview(photoTime)
        self.addSubview(dateView)

        
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        
        mostRecentFootCheckLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16).isActive = true
        mostRecentFootCheckLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        
        photo.topAnchor.constraint(equalTo: mostRecentFootCheckLabel.bottomAnchor, constant: 16).isActive = true
        photo.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        photo.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        photo.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        
        dateView.bottomAnchor.constraint(equalTo: photo.bottomAnchor, constant: -12).isActive = true
        dateView.leftAnchor.constraint(equalTo: photo.leftAnchor, constant: 12).isActive = true
        dateView.rightAnchor.constraint(equalTo: photo.rightAnchor, constant: -12).isActive = true
        dateView.heightAnchor.constraint(equalToConstant: 40).isActive = true

        photoDate.centerYAnchor.constraint(equalTo: dateView.centerYAnchor, constant: 0).isActive = true
        photoDate.leftAnchor.constraint(equalTo: dateView.leftAnchor, constant: 12).isActive = true

        photoTime.centerYAnchor.constraint(equalTo: dateView.centerYAnchor, constant: 0).isActive = true
        photoTime.rightAnchor.constraint(equalTo: dateView.rightAnchor, constant: -12).isActive = true
    
    }
    
    // UI Components
    
    let title: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        l.textColor = .systemPurple
        l.text = "Foot Check"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let mostRecentFootCheckLabel: UILabel = {
        let l = UILabel()
        l.text = "Most Recent Foot Check"
        l.textColor = .secondaryLabel
        l.font = UIFont.systemFont(ofSize: 18, weight: .light)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let photo: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "no-photo.png")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 25
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let dateView: UIView = {
        let v = UIView()
        v.backgroundColor = .tertiarySystemBackground
        v.layer.cornerRadius = 20
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let photoDate: UILabel = {
        let l = UILabel()
        l.textColor = .label
        l.font = UIFont.systemFont(ofSize: 18, weight: .light)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let photoTime: UILabel = {
        let l = UILabel()
        l.textColor = .secondaryLabel
        l.font = UIFont.systemFont(ofSize: 18, weight: .light)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    // Logic

    func setMostRecentFootCheck(footCheck: FootCheck) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        self.photo.image = UIImage(data: footCheck.image!)
        self.photoDate.isHidden = false
        self.photoDate.text = formatter.string(from: footCheck.date!)
        formatter.dateFormat = "h:mm a"
        self.photoTime.isHidden = false
        self.photoTime.text = formatter.string(from: footCheck.date!)
    }
    
    func setToBlank() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        self.photo.image = UIImage(named: "no-photo.png")
        self.photoDate.isHidden = true
        self.photoTime.isHidden = true
    }
    
}
