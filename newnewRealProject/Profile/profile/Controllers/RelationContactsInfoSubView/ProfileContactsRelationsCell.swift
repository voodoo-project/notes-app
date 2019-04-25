//
//  ProfileContactsRelationsCell.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 04/03/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit

class ProfileContactsRelationsCell: UITableViewCell {

    //MARK: Outlets:
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    //MARK: didSet
    var infoCell:ProfileContactsRelations?{
        didSet{
            do {
                profileName.text = "Связи через: " + (infoCell?.name)!
                profileImageView.image = UIImage(data: try Data(contentsOf: (infoCell?.image)!))
            } catch {
                print("error=\(String(describing: error))")
            }
        }
    }
    
}
