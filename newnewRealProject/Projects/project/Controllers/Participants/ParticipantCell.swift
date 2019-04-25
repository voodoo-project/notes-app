//
//  ParticipantCell.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 23/03/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit

class ParticipantCell: UITableViewCell {

    //Outlets:
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: didSet
    var infoCell:Participant?{
        didSet{
            do {
                infoLabel.text = infoCell?.someInfo
                nameLabel.text = infoCell?.name
                profileImageView.image = UIImage(data: try Data(contentsOf: (infoCell?.imageURL)!))
            } catch {
                print("error=\(String(describing: error))")
            }
        }
    }
}
