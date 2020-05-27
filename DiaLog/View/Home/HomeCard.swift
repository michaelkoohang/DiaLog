//
//  HomeCard.swift
//  DiaLog
//
//  Created by Michael Koohang on 5/23/20.
//  Copyright © 2020 Koohang. All rights reserved.
//

import UIKit

class HomeCard: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "default")
        self.selectionStyle = .none
        self.backgroundColor = .secondarySystemGroupedBackground
        self.layer.cornerRadius = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
