//
//  ProjectListVC.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 25/03/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit

class ProjectListVC: UIViewController,UITableViewDelegate,UITableViewDataSource{

    //MARK: Outlets:
    @IBOutlet weak var myTableView: UITableView!
    
    
    //MARK: Properties:
    private var projectListModel = MyProject()
    private var cellInfo:[Project] = []
    private var cellId = "projectListId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        projectListModel.retreiveMyProjects { [weak self] projects in
            self?.cellInfo = projects
            self?.myTableView.reloadData()
        }
    }
    
    //MARK: TableView:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProjectCell
        cell.infoCell = cellInfo[indexPath.row]
        return cell
    }
    
}
