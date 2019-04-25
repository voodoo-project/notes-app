//
//  ContactCell.swift
//  newRealProject
//
//  Created by Захар  Сегал on 14/02/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var someInfoLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    var contact:ContactsModel?{
        didSet{
            do {
                nameLabel.text = contact?.name
                someInfoLabel.text = contact?.someInfo
                profileImageView.image = UIImage(data: try Data(contentsOf: (contact?.image)!))
            } catch  {
                print(error)
            }
            
//            if let image = contact?.image{
//                profileImageView.image = UIImage(data: Data(contentsOf: contact?.image))
//            }
        }
    }
}
