//
//  SettingsVC.swift
//  DiaLog
//
//  Created by Michael Koohang on 5/23/20.
//  Copyright © 2020 Koohang. All rights reserved.
//

import UIKit
import SafariServices

class SettingsVC: BaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        self.modalPresentationStyle = .fullScreen
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "settingsCell")
        setup()
    }
    
    func setup() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
    }
    
    let tableView: UITableView = {
        let t = UITableView()
        t.backgroundColor = .systemGroupedBackground
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
}

extension SettingsVC: UITableViewDataSource, UITableViewDelegate {
    
    // Headers and footers.
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
        return 25
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UILabel()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
            let l = UILabel()
            l.textColor = .systemGray
            l.textAlignment = .center
            l.text = "Dia/Log v\(version)"
            return l
        }
        return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 400))
    }
    
    // Rows and cells.
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
            switch indexPath.row {
            case 0:
                self.present(SFSafariViewController(url: URL(string: "https://carnotes-api.herokuapp.com")!), animated: true)
            case 1:
                self.present(SFSafariViewController(url: URL(string: "https://carnotes-api.herokuapp.com/privacy")!), animated: true)
            case 2:
                self.present(SFSafariViewController(url: URL(string: "https://carnotes-api.herokuapp.com/privacy")!), animated: true)
            default:
                break
            }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingsCell()
        
            switch indexPath.row {
            case 0:
                cell.configure(type: .About)
            case 1:
                cell.configure(type: .PrivacyPolicy)
            default:
                break
            }
        
        return cell
    }
}


