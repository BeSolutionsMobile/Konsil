//
//  FilesTableViewCell.swift
//  Konsil
//
//  Created by Ali Mohamed on 1/28/20.
//  Copyright © 2020 begroup. All rights reserved.
//

import UIKit

class FilesTableViewCell: UITableViewCell {

    @IBOutlet weak var fileName: UILabel!
    @IBOutlet weak var fileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
