//
//  MessagesTableViewCell.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/17/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var cellImage: UIImageView!{
        didSet{
            cellImage.layer.cornerRadius = cellImage.frame.height / 2
            cellImage.layer.borderWidth = 1.5
            cellImage.layer.borderColor = #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1)
            cellImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var message: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
