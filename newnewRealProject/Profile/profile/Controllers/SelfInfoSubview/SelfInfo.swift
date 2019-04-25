//
//  SelfInfo.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 28/02/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit

class SelfInfo: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK: Properties:
    private var infoCellId = "SelfInfoCell"
    var profileModel = ProfileInfo()
    var cellInfo:[TableCellInfo] = []
    
    //MARK: Outlets:
    @IBOutlet weak var selfInfoTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selfInfoTableView.register(UINib.init(nibName: infoCellId , bundle: nil), forCellReuseIdentifier: infoCellId)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("hello")
        profileModel.retreiveSelfInfos { [weak self] tableCellInfos in
            self?.cellInfo = tableCellInfos
            self?.selfInfoTableView.reloadData()
            print("hello")
        }
    }
    
    
    //MARK: tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: infoCellId, for: indexPath) as! SelfInfoCell
        cell.infoCell = cellInfo[indexPath.row]
        return cell
    }
    

}

