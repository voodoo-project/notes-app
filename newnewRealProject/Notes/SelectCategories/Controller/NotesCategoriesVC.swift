//
//  NotesCategoriesVC.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 01/04/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit
import CoreData


class NotesCategoriesVC: UIViewController {

    
    //MARK: Properties:
    let infoCellId = "categoriesCellId"
    var categories:[Categories] = []
    var tableViewInfo:[String] = ["+"]
    var resultsController = CoreDataStack.instance.fetchedResultsController(entityName: "Categories", keyForSort: "date", ascending: false)
    
    //lazy var context = coreDataStack.notesContainer.viewContext
    
    
    //MARK: Outlets:
    @IBOutlet weak var myTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.isScrollEnabled = false
        print("VIEWDIDLOAD")
        print(".")
        //MARK: Request:
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        
//        let fetchRequest: NSFetchRequest<Categories> = Categories.fetchRequest()
//        let dateSort = NSSortDescriptor(key: "date", ascending:  false)
//        fetchRequest.sortDescriptors = [dateSort]
        //print(categories)
        do {
            
            //MARK: DElete all (uncomment the code below to delete all objects in Categories)
//            if let result = try? context.fetch(fetchRequest){
//                for object in result {
//                    context.delete(object)
//                }
//                do {
//                    try context.save()
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }

            //categories = try self.context.fetch(fetchRequest)
            do {
                try resultsController.performFetch()
            } catch  {
                print("Perform fetch error: \(error)")
            }
            var isExist:Bool = false
            let results = resultsController.fetchedObjects as? [Categories]
            guard let resultss = results else {return}
            self.categories = resultss
            for object in categories {
                if object.name == "все" {
                    isExist = true
                }
            }
            
            if isExist == false {
                saveCategorie(categorieToSave: "все",isMadeByUser: false)
            }
            var reversedCategories = categories
            reversedCategories.reverse()
            for cat in reversedCategories{
                print("CATEGORIES: \(cat.name)")
                //tableViewInfo.append(cat.name ?? "error")
                //tableViewInfo.append(cat.name ?? "error")
                tableViewInfo.insert(cat.name ?? "error", at: 0)
            }
            
            
            // tableViewInfo =  try categories.name
        } catch {
            print(error.localizedDescription)
    }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("categories: \(categories)")
        print("tableViewInfo: \(tableViewInfo)")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)

    }
    //MARK: AlertWithTextFields:
    func showAlertTextFields(_ inViewController: UIViewController, title: String, message: String,numberOfTextFields: Int,placeHolders: [String]){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "добавить категорию"
        }
        let action = UIAlertAction(title: "Добавить", style: .default) { (_) in
            let info = alert.textFields![0].text
            if !(info == "ВСЕ" || info == "все"){
            self.saveCategorie(categorieToSave: info ?? "error saving",isMadeByUser: true)
                //self.categories.reverse()
                self.myTableView.reloadData()
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
                
                do {
                    try
                        self.resultsController.managedObjectContext.save()
                        //self.coreDataStack.managedNotesContext.save()
                    print("SAVED")
                } catch  {
                    print("Error saving todo: \(error)")
                }
            }
            else {
                let newAlert = UIAlertController(title: "Warning", message: "зарезервированное имя", preferredStyle: .alert)

                let newAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                newAlert.addAction(newAction)
                self.present(newAlert, animated: true, completion: nil)
            }
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveCategorie(categorieToSave: String,isMadeByUser: Bool){
        
        let categorieObject = Categories()
        categorieObject.name = categorieToSave
        categorieObject.date = Date() as NSDate 
        
        do {
            try resultsController.managedObjectContext.save()
        } catch  {
            print(error.localizedDescription)
        }
       
        //categories.insert(categorieObject, at: 0)
        //categories.reverse()
            categories.append(categorieObject)
        if isMadeByUser == true{
            tableViewInfo.insert(categorieObject.name ?? "error", at: 0)
        }
        print("SAVED")
        print("saved categorie: \(String(describing: categorieObject.name))")
        print("saved date: \(String(describing: categorieObject.date))")
       
    }
    
    override func viewWillLayoutSubviews() {
       
        //super.viewWillLayoutSubviews()
        preferredContentSize = CGSize(width: 250, height: myTableView.contentSize.height)
        //preferredContentSize = CGSize(width: 250, height: 300)
    }
    
    

}




