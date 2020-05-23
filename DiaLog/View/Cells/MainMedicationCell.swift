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
        self.contentView.backgroundColor = .secondarySystemBackground
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        self.addSubview(icon)
        self.addSubview(title)
        self.addSubview(dosage)
        self.addSubview(unitsAndFrequency)
        
        icon.topAnchor.constraint(equalTo: self.topAnchor, constant: 18).isActive = true
        icon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        title.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 12).isActive = true
        title.centerYAnchor.constraint(equalTo: icon.centerYAnchor, constant: 0).isActive = true
        
        dosage.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4).isActive = true
        dosage.leftAnchor.constraint(equalTo: title.leftAnchor, constant: 0).isActive = true
        
        unitsAndFrequency.lastBaselineAnchor.constraint(equalTo: dosage.lastBaselineAnchor, constant: 0).isActive = true
        unitsAndFrequency.leftAnchor.constraint(equalTo: dosage.rightAnchor, constant: 8).isActive = true
        unitsAndFrequency.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    // UI Components
    
    let icon: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(systemName: "capsule.fill")
        imv.contentMode = .scaleAspectFit
        imv.tintColor = .systemBlue
        imv.translatesAutoresizingMaskIntoConstraints = false
        return imv
    }()
    
    let title: UILabel = {
        let l = UILabel()
        l.textColor = .label
        l.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let dosage: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        l.textColor = .secondaryLabel
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let unitsAndFrequency: UILabel = {
        let l = UILabel()
        l.textColor = .secondaryLabel
        l.font = UIFont.systemFont(ofSize: 18, weight: .light)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    // Logic

    func configureCell(medication: Medication) {
        self.title.text = medication.name
        self.dosage.text = String(medication.dosage)
        self.dosage.textColor = .systemBlue
        self.unitsAndFrequency.text = medication.units! + " " + medication.frequency!
    }
    
}
