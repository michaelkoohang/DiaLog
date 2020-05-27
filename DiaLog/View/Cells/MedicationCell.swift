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
        
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            icon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            icon.heightAnchor.constraint(equalToConstant: 30),
            icon.widthAnchor.constraint(equalToConstant: 30),
            
            title.centerYAnchor.constraint(equalTo: icon.centerYAnchor, constant: 0),
            title.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 16),
            
            dosage.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            dosage.leftAnchor.constraint(equalTo: title.leftAnchor, constant: 0),
            
            unitsAndFrequency.lastBaselineAnchor.constraint(equalTo: dosage.lastBaselineAnchor, constant: 0),
            unitsAndFrequency.leftAnchor.constraint(equalTo: dosage.rightAnchor, constant: 8),
            
            notes.topAnchor.constraint(equalTo: dosage.bottomAnchor, constant: 12),
            notes.leftAnchor.constraint(equalTo: title.leftAnchor, constant: 0),
            notes.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            notes.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
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
