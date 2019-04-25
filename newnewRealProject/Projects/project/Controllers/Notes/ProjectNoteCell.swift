//
//  ProjectNoteCell.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 28/03/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit

class ProjectNoteCell: UITableViewCell {

    
    @IBOutlet weak var myTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var infoCell:TableCellInfo?{
        didSet{
            do {
                myTextLabel.text = infoCell?.title
            } catch {
                print("error=\(String(describing: error))")
            }
        }
    }
    
}
