//
//  Item+CoreDataProperties.swift
//  Update
//
//  Created by R on 10/05/1443 AH.
//  Copyright © 1443 R. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: UUID?

}
