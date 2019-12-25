//
//  FAQTableViewCell.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/18/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
protocol DropDownDelegate {
    func updateView(label: UILabel , textField: DesignableUITextField)
}

class FAQTableViewCell: UITableViewCell {

    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var dropDown: DesignableUITextField!{
        didSet{
            self.dropDown.layer.cornerRadius = 7
            self.dropDown.layer.borderColor = UIColor.darkGray.cgColor
            self.dropDown.layer.borderWidth = 2
            
            self.dropDown.clipsToBounds = true
            self.dropDown.rightImage = #imageLiteral(resourceName: "Path 30")
        }
    }
   
    var delegate: DropDownDelegate?
    
   
    @IBAction func drop4(_ sender: UIButton) {
        delegate?.updateView(label: labelText, textField: dropDown)
    }
   
}
