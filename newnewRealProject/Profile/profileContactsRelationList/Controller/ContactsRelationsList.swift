//
//  ContactsRelationsList.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 11/03/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit

class ContactsRelationsList: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK: Properties:
    var contactsRelationsModel = ContactsRelations()
    var cellInfo:[RelationContact] = []
    var cellID = "ContactsRelationsCellID"
    var name:[String] = []
    
    //MARK: Outlets:
    @IBOutlet weak var myTableView: UITableView!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        contactsRelationsModel.retreiveInfo { [weak self] relationContacts in
            self?.cellInfo = relationContacts
            self?.myTableView.reloadData()
            print("hello")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.register(UINib.init(nibName: "ContactsRelationsCell" , bundle: nil), forCellReuseIdentifier: cellID)
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ContactsRelationsCell
        cell.infoCell = cellInfo[indexPath.row]
//        cell.infoCell?.name = cellInfo[indexPath.row].name! + "\(name)"
        return cell
    }
    
    

}
