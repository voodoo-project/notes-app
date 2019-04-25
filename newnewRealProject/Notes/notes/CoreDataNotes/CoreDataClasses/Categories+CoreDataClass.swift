//
//  Categories+CoreDataClass.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 12/04/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Categories)
public class Categories: NSManagedObject {
    
    convenience init() {
        
        self.init(entity: CoreDataStack.instance.entityForName(entityName: "Categories"), insertInto: CoreDataStack.instance.managedObjectContext)
//        // Описание сущности
//        let entity = NSEntityDescription.entity(forEntityName: "Categories", in: CoreDataStack.instance.managedObjectContext)
//
//        // Создание нового объекта
//        self.init(entity: entity!, insertInto: CoreDataStack.instance.managedObjectContext)
        
    }
    

}
