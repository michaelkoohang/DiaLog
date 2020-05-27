//
//  SettingsCell.swift
//  CarNotes
//
//  Created by Michael Koohang on 3/25/20.
//  Copyright © 2020 Michael Koohang. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    private let cellCover = UIView()
        
    enum cellType {
        case About
        case SiriShortcuts
        case PrivacyPolicy
    }
    
    func configure(type: cellType) {
        self.textLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        self.backgroundColor = .secondarySystemGroupedBackground
        self.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        
        cellCover.backgroundColor = .systemGray5
        cellCover.layer.cornerRadius = 10
        cellCover.layer.masksToBounds = true
        
        switch type {
            case .About:
                configureAbout()
            case .SiriShortcuts:
                configureSiriShortcuts()
            case .PrivacyPolicy:
                configurePrivacyPolicy()
        }
        
        self.selectedBackgroundView = cellCover
    }
    
    private func configureAbout() {
        self.textLabel?.text = "About"
        self.accessoryType = .disclosureIndicator
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.cellCover.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    private func configureSiriShortcuts() {
        self.textLabel?.text = "Siri Shortcuts"
        self.accessoryType = .disclosureIndicator
        self.layer.cornerRadius = 0
        self.cellCover.layer.cornerRadius = 0
    }
    
    private func configurePrivacyPolicy() {
        self.textLabel?.text = "Privacy Policy"
        self.accessoryType = .disclosureIndicator
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.cellCover.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

}
