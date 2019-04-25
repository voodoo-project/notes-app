//
//  SelfInfoCell.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 28/02/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit

class SelfInfoCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var infoCellLabel: UILabel!
    @IBOutlet weak var titleCellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK: cellDidSet
    var infoCell:TableCellInfo?{
        didSet{
            do {
                titleCellLabel.text = infoCell?.title
                infoCellLabel.text = infoCell?.info
            } catch {
                print("error=\(String(describing: error))")
            }
        }
    }
    
}
