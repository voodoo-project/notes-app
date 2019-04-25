//
//  ContactsRelationsCell.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 11/03/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit

class ContactsRelationsCell: UITableViewCell {
    
    
    //MARK: Outlets:
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    var infoCell:RelationContact?{
        didSet{
            do {
                infoLabel.text = infoCell?.info
                nameLabel.text = infoCell?.name
                profileImageView.image = UIImage(data: try Data(contentsOf: (infoCell?.imageURL)!))
            } catch {
                print("error=\(String(describing: error))")
            }
        }
    }
    
    
}
