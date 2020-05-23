//
//  FootCheckCell.swift
//  DiaLog
//
//  Created by Michael on 10/11/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit

class FootCheckCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "footcheck")
        self.backgroundColor = .systemBackground
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        self.addSubview(photo)
        self.addSubview(dateView)
        self.addSubview(photoDate)
        self.addSubview(photoTime)
        
        photo.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
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
    
    let photo: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "test-image.png")
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
        l.text = "May 29, 2019"
        l.textColor = .label
        l.font = UIFont.systemFont(ofSize: 18, weight: .light)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let photoTime: UILabel = {
        let l = UILabel()
        l.text = "1:49 PM"
        l.textColor = .secondaryLabel
        l.font = UIFont.systemFont(ofSize: 18, weight: .light)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    // Logic
    
    func configureCell(footCheck: FootCheck) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        self.photo.image = UIImage(data: footCheck.image!)
        self.photoDate.text = formatter.string(from: footCheck.date!)
        formatter.dateFormat = "h:mm a"
        self.photoTime.text = formatter.string(from: footCheck.date!)
    }

}
