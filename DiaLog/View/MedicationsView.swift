//
//  MedicationsView.swift
//  DiaLog
//
//  Created by Michael on 7/8/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit
import CoreData

class MedicationsView: CardView, UITableViewDelegate, UITableViewDataSource {
    
    var medications = [Medication]()
    
    override init() {
        super.init()        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.estimatedRowHeight = 66
        self.tableview.backgroundColor = .secondarySystemBackground
        self.tableview.register(MainMedicationCell.self, forCellReuseIdentifier: "medication")
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        self.addSubview(title)
        self.addSubview(tableview)
        
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        
        tableview.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 0).isActive = true
        tableview.leftAnchor.constraint(equalTo: self.title.leftAnchor, constant: 8).isActive = true
        tableview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        tableview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
    }
    
    // UI Components
    
    let title: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        l.textColor = .systemBlue
        l.text = "Medications"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let tableview: UITableView = {
        let tv = UITableView()
        tv.isScrollEnabled = false
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    // Logic

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !medications.isEmpty {
            return medications.count
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "medication", for: indexPath) as? MainMedicationCell {
            if !medications.isEmpty {
                cell.configureCell(medication: medications[indexPath.row])
            } else {
                cell.title.text = "No Medications"
                cell.dosage.text = ""
                cell.unitsAndFrequency.text = ""
            }
            return cell
        }
        
        return MainMedicationCell()
    }
    
    func updateMedications(data: [Medication]) {
        self.medications = data
        tableview.reloadData()
        layoutIfNeeded()
    }

}
