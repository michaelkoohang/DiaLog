//
//  A1C+CoreDataProperties.swift
//  
//
//  Created by Michael Koohang on 5/23/20.
//
//

import Foundation
import CoreData


extension A1C {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<A1C> {
        return NSFetchRequest<A1C>(entityName: "A1C")
    }

    @NSManaged public var date: Date?
    @NSManaged public var value: Double

}
