//
//  InputPickerCell.swift
//  DiaLog
//
//  Created by Michael Koohang on 5/26/20.
//  Copyright © 2020 Koohang. All rights reserved.
//

import UIKit

class InputPickerCell: InputCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let picker = UIPickerView()
    var options = [String]()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        picker.delegate = self
        self.input.inputView = self.picker
    }
    
    convenience init(iconTitle: String, placeholder: String, options: [String], position: Int) {
        self.init()
        icon.image = UIImage(systemName: iconTitle)
        input.placeholder = placeholder
        self.options = options
        if position == 0 {
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else if position == 1 {
            self.layer.cornerRadius = 0
        } else if position == 2 {
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        setup(position: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.input.text = options[row]
    }

}
