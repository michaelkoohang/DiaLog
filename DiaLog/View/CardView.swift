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
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 25
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
