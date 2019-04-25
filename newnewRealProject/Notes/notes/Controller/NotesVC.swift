//
//  NotesVCTableViewController.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 21/02/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit
import CoreData
class NotesVC: UITableViewController {

    
    //MARK: Properties:
//    let model = NoteListModel()
//    var notes:[NotesModel] = []
    //let entity = CoreDataStack.instance.entityForName(entityName: "Notes")
    let resultsController = CoreDataStack.instance.fetchedResultsControllerPredicate(entityName: "Notes", keyForSort: "date", ascending: true, toWhatRelated: "все")
    
    
    //MARK: Outlets:
    @IBOutlet weak var myButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
        //MARK: Fetch
        resultsController.delegate = self
        do {
            try resultsController.performFetch()
        } catch  {
            print("Perform fetch error: \(error)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        model.retreiveNotes { [weak self] notes in
//            self?.notes = notes
//            self?.tableView.reloadData()
//        }
    }
    
    
    //MARK: fetching result controller
    
    
    
    //MARK: SetupGesturesForCategoriesButton
    private func setupGestures(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGesture.numberOfTapsRequired = 1
        myButton.addGestureRecognizer(tapGesture)
        
    }
    
    @objc private func tapped(){
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "NotesCategoriesVC")
            else {
                return
        }
        popVC.modalPresentationStyle = .popover
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.myButton
        popOverVC?.sourceRect = CGRect(x: self.myButton.bounds.midX, y: self.myButton.bounds.maxY, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: 250, height: 250)
        
        self.present(popVC, animated: true)
        
    }
    
    
    
    // MARK: - Table view data source
    
}
