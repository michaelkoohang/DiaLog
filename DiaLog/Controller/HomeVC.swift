//
//  MainVC.swift
//  DiaLog
//
//  Created by Michael on 5/29/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit
import CoreData
import ScrollableGraphView

class HomeVC: BaseVC {
    
    let hapticFeedback = UISelectionFeedbackGenerator()
    var medicationsViewHeight: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGroupedBackground
        tableView.estimatedRowHeight = 500
        tableView.register(HomeTargetCard.self, forCellReuseIdentifier: "htgc")
        tableView.register(HomeTodayCard.self, forCellReuseIdentifier: "htdc")
        tableView.register(HomeDateCard.self, forCellReuseIdentifier: "hdc")
        tableView.register(HomeA1CCard.self, forCellReuseIdentifier: "ha1c")


        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
                   tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
                   tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
                   tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    let tableView: UITableView = {
        let t = UITableView(frame: CGRect(), style: .grouped)
        t.backgroundColor = .systemBackground
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // Navigation
    
    @objc func goToBloodSugar() {
        hapticFeedback.selectionChanged()
        self.navigationController?.pushViewController(BloodSugarVC(), animated: true)
    }
    
    @objc func goToA1C() {
        hapticFeedback.selectionChanged()
        self.navigationController?.pushViewController(A1CVC(), animated: true)
    }
    
    @objc func goToMedications() {
        hapticFeedback.selectionChanged()
        self.navigationController?.pushViewController(MedicationsVC(), animated: true)
    }
    
    @objc func goToFootCheck() {
        hapticFeedback.selectionChanged()
        self.navigationController?.pushViewController(FootCheckVC(), animated: true)
    }
    
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
        
        if section == 2 {
            return 0
        }
        
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 5 {
            return 30
        }
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let l = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        l.font = UIFont.systemFont(ofSize: 24, weight: .bold)

        switch section {
        case 1:
            l.text = "Blood Sugar"
            l.textColor = .systemRed
        case 3:
            l.text = "A1C"
            l.textColor = .systemGreen
        case 4:
            l.text = "Medications"
            l.textColor = .systemBlue
        case 5:
            l.text = "Foot Check"
            l.textColor = .systemOrange
        default:
            break
        }
        return l
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UILabel()
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 2:
            self.navigationController?.pushViewController(BloodSugarVC(), animated: true)
        case 3:
            self.navigationController?.pushViewController(A1CVC(), animated: true)
        case 4:
            self.navigationController?.pushViewController(MedicationsVC(), animated: true)
        case 5:
            self.navigationController?.pushViewController(FootCheckVC(), animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = HomeDateCard()
            return cell
        case 1:
            let cell = HomeTargetCard()
            cell.configureCell()
            return cell
        case 2:
            let cell = HomeTodayCard()
            cell.configureCell()
            return cell
        case 3:
            let cell = HomeA1CCard()
            cell.configureCell()
            return cell
        case 4:
            let cell = HomeMedicationsCard()
            cell.configureCell()
            return cell
        case 5:
            let cell = HomeFootCheckCard()
            cell.configureCell()
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
    
}
