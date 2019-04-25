//
//  ContactsProfileVC.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 19/02/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit

class ContactsProfileVC: UIViewController {

    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var ProfileImage: UIImageView!
    var profile: ContactsModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillUIElements()
        
    }
    func fillUIElements(){
        do {
            ProfileImage.image = UIImage(data: try Data(contentsOf: profile.image!))
            NameLabel.text = profile.name
        } catch  {
            print(error)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
