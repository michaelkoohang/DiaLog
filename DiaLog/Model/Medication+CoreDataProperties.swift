//
//  Medication+CoreDataProperties.swift
//  
//
//  Created by Michael Koohang on 5/23/20.
//
//

import Foundation
import CoreData


extension Medication {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Medication> {
        return NSFetchRequest<Medication>(entityName: "Medication")
    }

    @NSManaged public var dosage: Int16
    @NSManaged public var frequency: String?
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var units: String?

}
