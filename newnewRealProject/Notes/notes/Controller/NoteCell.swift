//
//  NoteCell.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 25/02/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {

    
    @IBOutlet weak var textLabelOne: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    var note:NotesModel?{
        didSet{
            do {
                textLabelOne.text = note?.text
            } catch  {
                print(error)
            }
        }
    }
    
    
}
