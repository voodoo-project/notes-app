//
//  NotesCategoriesExtension.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 18/04/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension NotesCategoriesVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        switch tableViewInfo[indexPath.row] {
        case "+":
             return nil
        case "все":
            AlertController.showAlert(self, title: "Warning", message: "OK")
            return nil
        default:
            let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
               // let todo = self.resultsController.object(at: indexPath) as! Categories
                let todos = self.categories[indexPath.row]
//                let managedObject = fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
//                CoreDataManager.instance.managedObjectContext.deleteObject(managedObject)
//                CoreDataManager.instance.saveContext()
                print("deleting: \(String(describing: todos.name)), atIndex: \(indexPath.row)")
                print("deleting: \(self.tableViewInfo[indexPath.row]), atIndex: \(indexPath.row)")
                //print(todo.name)
                //self.context.delete(todo)
                CoreDataStack.instance.managedObjectContext.delete(todos)
                //print(self.tableViewInfo[indexPath.row])
                self.tableViewInfo.remove(at: indexPath.row)
                //tableView.reloadData()
                    CoreDataStack.instance.saveContext()
                    //try self.context.save()
                    tableView.reloadData()
                    self.view.setNeedsLayout()
                    self.view.layoutIfNeeded()
                    print("DELETING SAVED")
                    completion(true)
            }
            action.image = UIImage(named: "trash")
            action.backgroundColor = .red
            return UISwipeActionsConfiguration(actions: [action])
        }
       
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: infoCellId, for: indexPath) as! CategoriesCell
        cell.myTextLabel.text = tableViewInfo[indexPath.row]
        print("TABLEVIEWMETHOD : \(cell.myTextLabel.text)")
        //        if indexPath.row == categories.count {
        //            cell.myTextLabel.text = "+"
        //            print("indexPath.row == categories.count")
        //        }
        //        else{
        //            cell.myTextLabel.text =
        //        }
        //cell.myTextLabel.text = categorie.name
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(tableViewInfo.count)
        return tableViewInfo.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != tableViewInfo.count-1 {
            //print(indexPath.row)
        }
        else {
            showAlertTextFields(self, title: "Alert", message: "добавить категорию", numberOfTextFields: 1, placeHolders: ["категория"])
            //            DispatchQueue.main.asyncAfter(deadline: .now()) {
            //               DispatchTime.now() + 0.3
            //            }
        }
    }
    
}

extension NotesCategoriesVC: NSFetchedResultsControllerDelegate {
        func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            self.myTableView.beginUpdates()
        }
        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            self.myTableView.endUpdates()
        }
        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
            switch type {
            case .insert:
                if let indexPath = newIndexPath{
                    self.myTableView.insertRows(at: [indexPath], with: .automatic)
                }
            case .delete:
                if let indexPath = indexPath {
                    self.myTableView.deleteRows(at: [indexPath], with: .automatic)
                }
            case .update:
                if let indexPath = indexPath, let cell = self.myTableView.cellForRow(at: indexPath){
                    let todo = resultsController.object(at: indexPath) as! Categories
                    cell.textLabel?.text = todo.name
                }
            default:
                break
            }
        }
}
