//
//  MedicationCell.swift
//  DiaLog
//
//  Created by Michael on 7/25/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit

class MedicationCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "medication")
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
        self.addSubview(notes)
        
        icon.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        icon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        title.centerYAnchor.constraint(equalTo: icon.centerYAnchor, constant: 0).isActive = true
        title.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 16).isActive = true
    
        dosage.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4).isActive = true
        dosage.leftAnchor.constraint(equalTo: title.leftAnchor, constant: 0).isActive = true
        
        unitsAndFrequency.lastBaselineAnchor.constraint(equalTo: dosage.lastBaselineAnchor, constant: 0).isActive = true
        unitsAndFrequency.leftAnchor.constraint(equalTo: dosage.rightAnchor, constant: 8).isActive = true
        
        notes.topAnchor.constraint(equalTo: dosage.bottomAnchor, constant: 12).isActive = true
        notes.leftAnchor.constraint(equalTo: title.leftAnchor, constant: 0).isActive = true
        notes.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        notes.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        
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
        l.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let dosage: UILabel = {
        let l = UILabel()
        l.textColor = .secondaryLabel
        l.font = UIFont.systemFont(ofSize: 28, weight: .medium)
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
    
    let notes: UILabel = {
        let l = UILabel()
        l.textColor = .label
        l.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        l.numberOfLines = 5
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    // Logic
    
    func configureCell(medication: Medication) {
        self.title.text = medication.name!
        self.dosage.text = String(Int(medication.dosage))
        self.dosage.textColor = .systemBlue
        self.unitsAndFrequency.text = "\(medication.units!) \(medication.frequency!)"
        self.notes.text = medication.notes!.isEmpty ? "No Notes" : medication.notes!
    }
    
}
