//
//  Notes+CoreDataClass.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 12/04/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Notes)
public class Notes: NSManagedObject {

    convenience init() {
        self.init(entity: CoreDataStack.instance.entityForName(entityName: "Notes"), insertInto: CoreDataStack.instance.notesContainer.viewContext)
        
    }
    
    
    
}
