//
//  DoctorsTableViewCell.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/16/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import Cosmos
class DoctorsTableViewCell: UITableViewCell {

    @IBOutlet weak var drImage: UIImageView!{
        didSet{
            drImage.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var drName: UILabel!
    @IBOutlet weak var drDegree: UILabel!
    @IBOutlet weak var drRating: CosmosView!
    @IBOutlet weak var languages: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            contentView.backgroundColor = .clear
            let bgColorView = UIView()
            bgColorView.backgroundColor = .clear
            
            self.selectedBackgroundView = bgColorView
        } else {
            contentView.backgroundColor = .clear
        }
    }

}
