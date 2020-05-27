//
//  CardView.swift
//  DiaLog
//
//  Created by Michael Koohang on 5/21/20.
//  Copyright © 2020 Koohang. All rights reserved.
//

import UIKit

class CardView: UIView {

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.backgroundColor = .secondarySystemGroupedBackground
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.cornerRadius = 10
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
