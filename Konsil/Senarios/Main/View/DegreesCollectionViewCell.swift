//
//  DegreesCollectionViewCell.swift
//  Konsil
//
//  Created by Ali Mohamed on 2/19/20.
//  Copyright © 2020 begroup. All rights reserved.
//

import UIKit
import BEMCheckBox

protocol SelectDegreeDelegate {
    func toggleCheck(id: Int , checkBox: BEMCheckBox , status: Bool)
}
class DegreesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var degreeTitle: UILabel!
    @IBOutlet weak var selectCheckBox: BEMCheckBox!{
        didSet{
            selectCheckBox.onAnimationType = .bounce
            selectCheckBox.offAnimationType = .bounce
        }
    }
    var id: Int?
    var delegate: SelectDegreeDelegate?
    
    @IBAction func didtapcheckbox(_ sender: BEMCheckBox) {
        let checked: Bool = selectCheckBox.on
        if let id = id {
            delegate?.toggleCheck(id: id, checkBox: selectCheckBox, status: checked)
        }
    }
}
