//
//  PeriodsTableViewCell.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/18/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import BEMCheckBox

protocol CheckBoxDelegate {
    func choosePeriod(checkBox: BEMCheckBox , cell: UITableViewCell)
}

class PeriodsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkBox: BEMCheckBox!
    @IBOutlet weak var period: UILabel!
    var delegate: CheckBoxDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    @IBAction func checkAndUncheck(_ sender: BEMCheckBox) {
        delegate?.choosePeriod(checkBox: checkBox ,cell: self )
    }
    
}
