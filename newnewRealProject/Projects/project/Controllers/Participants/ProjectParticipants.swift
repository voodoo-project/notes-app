//
//  ProjectParticipants.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 22/03/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit

class ProjectParticipants: UIViewController {

    //MARK: Properties:
    private var cellId = "ParticipantCellId"
    private var projectParticipantModel = ProjectParticipant()
    private var cellInfo:[Participant] = []
    
    //MARK: Outlets:
    @IBOutlet weak var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.register(UINib.init(nibName: "ParticipantCell" , bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        projectParticipantModel.retreiveMyParticipants { [weak self] projectParticipant in
            self?.cellInfo = projectParticipant
            self?.myTableView.reloadData()
        }
    }
}

extension ProjectParticipants:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ParticipantCell
        cell.infoCell = cellInfo[indexPath.row]
        return cell
    }
}
