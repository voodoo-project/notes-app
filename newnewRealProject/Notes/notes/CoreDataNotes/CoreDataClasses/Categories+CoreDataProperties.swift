//
//  Categories+CoreDataProperties.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 21/04/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//
//

import Foundation
import CoreData


extension Categories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categories> {
        return NSFetchRequest<Categories>(entityName: "Categories")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var notesRelated: NSSet?

}

// MARK: Generated accessors for notesRelated
extension Categories {

    @objc(addNotesRelatedObject:)
    @NSManaged public func addToNotesRelated(_ value: Notes)

    @objc(removeNotesRelatedObject:)
    @NSManaged public func removeFromNotesRelated(_ value: Notes)

    @objc(addNotesRelated:)
    @NSManaged public func addToNotesRelated(_ values: NSSet)

    @objc(removeNotesRelated:)
    @NSManaged public func removeFromNotesRelated(_ values: NSSet)

}
