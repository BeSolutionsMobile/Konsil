//
//  MyConsultationsTableViewCell.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/19/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

protocol ConsultationDelegate {
    func viewDidPressed()
}

class MyConsultationsTableViewCell: UITableViewCell {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tybe: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var doctorImage: UIImageView!{
        didSet{
            Rounded.roundedImage(imageView: doctorImage, radius: self.doctorImage.frame.width/2, borderColor: #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1), borderWidth: 1.5)
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
    var delegate: ConsultationDelegate?
    
    @IBAction func view(_ sender: UIButton) {
        delegate?.viewDidPressed()
    }
    
}
