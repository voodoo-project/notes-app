//
//  Notes+CoreDataProperties.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 21/04/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var priority: Int16
    @NSManaged public var title: String?
    @NSManaged public var categorieRelated: Categories?

}
