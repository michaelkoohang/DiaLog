//
//  BloodSugar+CoreDataProperties.swift
//  
//
//  Created by Michael Koohang on 5/23/20.
//
//

import Foundation
import CoreData


extension BloodSugar {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BloodSugar> {
        return NSFetchRequest<BloodSugar>(entityName: "BloodSugar")
    }

    @NSManaged public var date: Date?
    @NSManaged public var type: String?
    @NSManaged public var value: Int16

}
