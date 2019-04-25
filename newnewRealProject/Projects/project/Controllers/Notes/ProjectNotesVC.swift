//
//  ProjectNotes.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 22/03/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit
import FirebaseStorage

class ProjectNotesVC: UIViewController {

    
    //MARK: Properties:
    private var infoCell = "ProjectNoteCellId"
    var imageReference:StorageReference {
        return FirebaseStorage.Storage().reference().child("images")
    }
//    var ProjectNotesModel
//    var cellInfo:[] = []
//
    //MARK: Outlets:
   
    @IBOutlet weak var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        projectParticipantModel.retreiveMyParticipants { [weak self] projectParticipant in
//            self?.cellInfo = projectParticipant
//            self?.myTableView.reloadData()
//        }
    }

    
    

}



//extension ProjectNotesVC:UITableViewDataSource,UITableViewDelegate{
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return cellInfo.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: infoCellId, for: indexPath) as! SelfInfoCell
//        cell.infoCell = cellInfo[indexPath.row]
//        return cell
//    }
//    
//}

