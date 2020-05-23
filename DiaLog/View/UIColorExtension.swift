//
//  UIColorExtension.swift
//  DiaLog
//
//  Created by Michael on 10/13/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {

     class func color(data:Data) -> UIColor? {
        return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
     }

     func encode() -> Data? {
          return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
     }
}
