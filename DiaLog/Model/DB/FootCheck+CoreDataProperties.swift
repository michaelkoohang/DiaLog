//
//  FootCheck+CoreDataProperties.swift
//  
//
//  Created by Michael Koohang on 5/23/20.
//
//

import Foundation
import CoreData


extension FootCheck {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FootCheck> {
        return NSFetchRequest<FootCheck>(entityName: "FootCheck")
    }

    @NSManaged public var date: Date?
    @NSManaged public var image: Data?

}
