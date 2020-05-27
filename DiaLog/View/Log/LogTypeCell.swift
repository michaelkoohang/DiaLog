//
//  LogCell.swift
//  DiaLog
//
//  Created by Michael Koohang on 5/24/20.
//  Copyright © 2020 Koohang. All rights reserved.
//

import UIKit
import Lottie

class LogTypeCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.contentView.addSubview(animationView)
        self.contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            animationView.bottomAnchor.constraint(equalTo: self.button.topAnchor, constant: 0),
            animationView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0),
            animationView.heightAnchor.constraint(equalToConstant: 60),
            animationView.widthAnchor.constraint(equalToConstant: 70),
            
            button.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),
            button.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 0),
            button.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 0),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    // UI Components
    
    let animationView: AnimationView = {
        let a = AnimationView()
        a.animation = Animation.named("heart")
        a.contentMode = .scaleAspectFit
        a.loopMode = .loop
        a.translatesAutoresizingMaskIntoConstraints = false
        return a
    }()
    
    let button: UIButton = {
        let b = UIButton()
        b.isUserInteractionEnabled = false
        b.backgroundColor = .secondarySystemGroupedBackground
        b.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        b.layer.cornerRadius = 10
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    // Logic
    
    func configureCell(type: LogType, active: Bool) {
        switch type {
        case .BloodSugar:
            if active {
                button.setTitleColor(.systemRed, for: .normal)
            } else {
                button.backgroundColor = .secondarySystemGroupedBackground
                button.setTitleColor(.tertiaryLabel, for: .normal)
            }
            animationView.animation = Animation.named("heart")
            button.setTitle("Blood Sugar", for: .normal)
        case .A1C:
            if active {
                button.setTitleColor(.systemGreen, for: .normal)
            } else {
                button.backgroundColor = .secondarySystemGroupedBackground
                button.setTitleColor(.tertiaryLabel, for: .normal)
            }
            animationView.animation = Animation.named("dots")
            button.setTitle("A1C", for: .normal)
        case .Medication:
            if active {
                button.setTitleColor(.systemBlue, for: .normal)
            } else {
                button.backgroundColor = .secondarySystemGroupedBackground
                button.setTitleColor(.tertiaryLabel, for: .normal)
            }
            animationView.animation = Animation.named("meds")
            button.setTitle("Medication", for: .normal)
        case .FootCheck:
            if active {
                button.setTitleColor(.systemOrange, for: .normal)
            } else {
                button.backgroundColor = .secondarySystemGroupedBackground
                button.setTitleColor(.tertiaryLabel, for: .normal)
            }
            animationView.animation = Animation.named("camera")
            button.setTitle("Foot Check", for: .normal)
        }
        animationView.play()
    }
    
}

