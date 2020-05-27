//
//  HomeMedicationsCard.swift
//  DiaLog
//
//  Created by Michael Koohang on 5/23/20.
//  Copyright © 2020 Koohang. All rights reserved.
//

import UIKit
import Lottie
import CoreData

class HomeMedicationsCard: HomeCard, UITableViewDelegate, UITableViewDataSource {
    
    var medications = [Medication]()
    var tableViewHeight: NSLayoutConstraint?
    
    init() {
        super.init(style: .default, reuseIdentifier: "hmc")
        NotificationCenter.default.addObserver(self, selector:#selector(restartAnimation), name:
        UIApplication.willEnterForegroundNotification, object: nil)
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = 80
        self.tableview.isScrollEnabled = false
        self.tableview.isUserInteractionEnabled = false
        self.tableview.separatorStyle = .none
        self.tableview.backgroundColor = .secondarySystemGroupedBackground
        self.tableview.register(MainMedicationCell.self, forCellReuseIdentifier: "medication")
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        self.contentView.addSubview(title)
        self.contentView.addSubview(chevron)
        self.contentView.addSubview(tableview)
        self.contentView.addSubview(noDataLabel)
        self.contentView.addSubview(startLoggingLabel)
        self.contentView.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            title.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            title.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            
            chevron.centerYAnchor.constraint(equalTo: title.centerYAnchor, constant: 0),
            chevron.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            chevron.heightAnchor.constraint(equalToConstant: 20),
            chevron.widthAnchor.constraint(equalToConstant: 20),
            
            tableview.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 8),
            tableview.leftAnchor.constraint(equalTo: self.title.leftAnchor, constant: 4),
            tableview.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            tableview.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            
            noDataLabel.centerYAnchor.constraint(equalTo: animationView.centerYAnchor, constant: -8),
            noDataLabel.leftAnchor.constraint(equalTo: self.animationView.rightAnchor, constant: 8),
            noDataLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),

            startLoggingLabel.centerYAnchor.constraint(equalTo: animationView.centerYAnchor, constant: 12),
            startLoggingLabel.leftAnchor.constraint(equalTo: self.animationView.rightAnchor, constant: 8),
            startLoggingLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            
            animationView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 12),
            animationView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            animationView.heightAnchor.constraint(equalToConstant: 60),
            animationView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        tableViewHeight = tableview.heightAnchor.constraint(equalToConstant: 80)
        tableViewHeight?.isActive = true

    }
    
    // UI Components
    
    let title: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        l.textColor = .secondaryLabel
        l.text = "Your Medications"
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
    
    let tableview: UITableView = {
        let tv = UITableView()
        tv.isScrollEnabled = false
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let noDataLabel: UILabel = {
        let l = UILabel()
        l.text = "No Medications"
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
        a.animation = Animation.named("meds")
        a.contentMode = .scaleAspectFit
        a.loopMode = .loop
        a.translatesAutoresizingMaskIntoConstraints = false
        return a
    }()
    
    // Logic
    
    private func updateMedications() {
        self.medications = DBHandler.getMedications()
        tableview.reloadData()
    }
    
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
                tableView.isHidden = false
                animationView.isHidden = true
                noDataLabel.isHidden = true
                startLoggingLabel.isHidden = true
                animationView.pause()
                cell.configureCell(medication: medications[indexPath.row])
            } else {
                tableView.isHidden = true
                animationView.isHidden = false
                noDataLabel.isHidden = false
                startLoggingLabel.isHidden = false
                animationView.play()
            }
            return cell
        }
        
        return MainMedicationCell()
    }
    
    func configureCell() {
        updateMedications()
        if !medications.isEmpty {
            tableViewHeight?.constant = CGFloat(60*medications.count)
        } else {
            tableViewHeight?.constant = CGFloat(70)
        }
    }
    
    @objc func restartAnimation() {
        animationView.play()
    }
    
}
