//
//  MyConsultationsTableViewCell.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/19/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

class MyConsultationsTableViewCell: UITableViewCell {

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var doctorImage: UIImageView!{
        didSet{
            self.doctorImage.layer.cornerRadius = self.doctorImage.frame.width/2
            self.doctorImage.layer.borderColor = #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1)
            self.doctorImage.layer.borderWidth = 1.5
        }
    }
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var viewBut: UIButton!{
        didSet{
            self.viewBut.layer.cornerRadius = self.viewBut.frame.height/2
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
