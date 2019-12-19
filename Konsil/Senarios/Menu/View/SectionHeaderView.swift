//
//  SectionHeaderView.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/19/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

class SectionHeaderView: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!{
        didSet{
            self.headerLabel.layer.cornerRadius = self.headerLabel.frame.height/2
            self.headerLabel.clipsToBounds = true
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
