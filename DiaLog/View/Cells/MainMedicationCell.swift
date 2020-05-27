//
//  MainMedicationCell.swift
//  DiaLog
//
//  Created by Michael on 7/24/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit

class MainMedicationCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "medication")
        self.contentView.backgroundColor = .secondarySystemGroupedBackground
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
//        self.addSubview(icon)
        self.contentView.addSubview(title)
        self.contentView.addSubview(dosage)
        self.contentView.addSubview(units)
        self.contentView.addSubview(frequency)

        
        NSLayoutConstraint.activate([
//            icon.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
//            icon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
//            icon.heightAnchor.constraint(equalToConstant: 30),
//            icon.widthAnchor.constraint(equalToConstant: 30),
            
            title.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 4),
            title.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            
            frequency.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            frequency.leftAnchor.constraint(equalTo: title.leftAnchor, constant: 0),
            frequency.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            
            dosage.centerYAnchor.constraint(equalTo: title.centerYAnchor, constant: 0),
            dosage.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -8),
            
            units.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -8),
            units.firstBaselineAnchor.constraint(equalTo: self.frequency.firstBaselineAnchor, constant: 0)
    
        ])
        
    }
    
    // UI Components
    
    let icon: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(systemName: "capsule")
        imv.contentMode = .scaleAspectFit
        imv.tintColor = .systemBlue
        imv.translatesAutoresizingMaskIntoConstraints = false
        return imv
    }()
    
    let title: UILabel = {
        let l = UILabel()
        l.textColor = .tertiaryLabel
        l.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let dosage: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        l.textColor = .systemBlue
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let units: UILabel = {
        let l = UILabel()
        l.textColor = .tertiaryLabel
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let frequency: UILabel = {
        let l = UILabel()
        l.textColor = .tertiaryLabel
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    // Logic
    
    func configureCell(medication: Medication) {
        self.title.text = medication.name
        self.dosage.text = String(medication.dosage)
        self.dosage.textColor = .systemBlue
        self.units.text = medication.units!
        self.frequency.text = medication.frequency!
    }
    
}
