//
//  RelationContactsInfo.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 28/02/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit

class RelationContactsInfo: UIViewController,UITableViewDelegate,UITableViewDataSource{
    //MARK: Outlets
    @IBOutlet weak var myTableView: UITableView!
    
    //MARK: Properties:
    var cellId = "ProfileContactsRelationsCellId"
    var profileRelationsModel = ProfileRelations()
    var cellInfo:[ProfileContactsRelations] = []
    let profileImageURL = URL(string: "https://img.icons8.com/color/96/000000/user-male-skin-type-3.png")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.register(UINib.init(nibName: "ProfileContactsRelationsCell" , bundle: nil), forCellReuseIdentifier: cellId)
        
        
    }
    func presentNextVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextPage = storyboard.instantiateViewController(withIdentifier: "ContactsRelationsList") as! ContactsRelationsList
        navigationController?.pushViewController(nextPage, animated: true)
        nextPage.view.backgroundColor = UIColor.green
        //present(nextPage, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("hello")
        profileRelationsModel.retreiveMyRelations { [weak self] profile_contacts_relation in
            self?.cellInfo = profile_contacts_relation
            self?.myTableView.reloadData()
            print("hello")
        }
    }
    
    //MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProfileContactsRelationsCell
        cell.infoCell = cellInfo[indexPath.row]
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presentNextVC()
    }
    
    
    
}
