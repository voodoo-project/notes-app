//
//  ProjectCell.swift
//  newnewRealProject
//
//  Created by Захар  Сегал on 25/03/2019.
//  Copyright © 2019 Захар  Сегал. All rights reserved.
//

import UIKit

class ProjectCell: UITableViewCell {

    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var projectImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: didSet
    var infoCell:Project?{
        didSet{
            do {
                projectLabel.text = infoCell?.name
                projectImage.image = UIImage(data: try Data(contentsOf: (infoCell?.imageURL)!))
            } catch {
                print("error=\(String(describing: error))")
            }
        }
    }

}
