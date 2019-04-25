//
//  CategoriesCell.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 01/04/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit

class CategoriesCell: UITableViewCell {


    @IBOutlet weak var myTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
//    var infoCell:_{
//        didSet{
//            do {
//                myTextLabel.text = infoCell.text
//            } catch {
//                print("error=\(String(describing: error))")
//
//            }
//        }
//    }

}
