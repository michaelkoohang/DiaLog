//
//  InputImageCell.swift
//  DiaLog
//
//  Created by Michael Koohang on 5/26/20.
//  Copyright © 2020 Koohang. All rights reserved.
//

import UIKit

class InputImageCell: UITableViewCell {
    
    private let cellCover = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "default")
        self.selectionStyle = .default
        self.backgroundColor = .secondarySystemGroupedBackground
        self.layer.cornerRadius = 10
        
        cellCover.backgroundColor = .systemGray5
        cellCover.layer.cornerRadius = 10
        cellCover.layer.masksToBounds = true
        self.selectedBackgroundView = cellCover
    }
    
    convenience init(iconTitle: String, text: String, position: Int) {
        self.init()
        icon.image = UIImage(systemName: iconTitle)
        label.text = text
        if position == 0 {
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else if position == 1 {
            self.layer.cornerRadius = 0
        } else if position == 2 {
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        setup(position: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(position: Int) {
        self.contentView.addSubview(icon)
        self.contentView.addSubview(label)
        self.contentView.addSubview(chevron)
        
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: self.label.centerYAnchor, constant: 0),
            icon.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            icon.widthAnchor.constraint(equalToConstant: 25),
            icon.heightAnchor.constraint(equalToConstant: 25),
            
            label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            label.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 16),
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            chevron.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 0),
            chevron.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            chevron.heightAnchor.constraint(equalToConstant: 20),
            chevron.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    let icon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "camera")
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .tertiaryLabel
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var label: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        l.text = "Take a picture"
        l.textColor = .tertiaryLabel
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

}
