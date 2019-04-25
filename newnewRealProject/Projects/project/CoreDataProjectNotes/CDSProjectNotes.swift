//
//  CDSProjectNotes.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 28/03/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import Foundation
import CoreData

class CDSProjectNotes {
    
    var container: NSPersistentContainer {
        let container = NSPersistentContainer(name: "ProjectNotes")
        container.loadPersistentStores { (description, error) in
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
        }
        return container
    }
    
    var managedContext: NSManagedObjectContext {
        return container.viewContext
    }
}
