//
//  ComplaintTableViewCell.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/19/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

class ComplaintTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!{
        didSet{
            userImage.layer.cornerRadius = userImage.frame.height / 2
            userImage.layer.borderWidth = 1.5
            userImage.layer.borderColor = #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1)
            userImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
