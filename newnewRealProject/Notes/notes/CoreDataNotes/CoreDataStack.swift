//
//  CoreDataStack.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 04/03/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    
    static let instance = CoreDataStack()
    
    private init() {}
    
    
    // Entity for Name
    func entityForName(entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: self.managedObjectContext)!
        
    }
    
    //FetchedResultsController For Entity name With Predicate:
    func fetchedResultsControllerPredicate(entityName: String, keyForSort: String, ascending: Bool, toWhatRelated: String) -> NSFetchedResultsController<Notes> {
        let fetchRequest = NSFetchRequest<Notes>(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: keyForSort, ascending: ascending)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let myPredicate = NSPredicate(format: "categorieRelated.name = %@", toWhatRelated)
        fetchRequest.predicate = myPredicate
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.instance.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        //fetchedResultsController.fetchRequest.predicate = NSPredicate
        return fetchedResultsController
        
    }
    
    
    //FetchedResultsController For Entity name Without Predicate:
    func fetchedResultsController(entityName: String, keyForSort: String,ascending: Bool) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        //let fetchRequest = NSFetchRequest<Notes>(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: keyForSort, ascending: ascending)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.instance.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        //fetchedResultsController.fetchRequest.predicate = NSPredicate
        return fetchedResultsController

    }
    
    
    //MARK: Container
     var notesContainer: NSPersistentContainer {
        let container = NSPersistentContainer(name: "Notes")
        container.loadPersistentStores { (description, error) in
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
        }
        return container
    }
    
    
    //MARK: managedObjectContext
     var managedObjectContext: NSManagedObjectContext {
        return notesContainer.viewContext
    }
    
    
    //MARK: saveContext
    func saveContext () {
                let context = notesContainer.viewContext
                if context.hasChanges {
                    do {
                        try context.save()
                    } catch {
        
                        let nserror = error as NSError
                        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                    }
                }
            }
    
    
}
