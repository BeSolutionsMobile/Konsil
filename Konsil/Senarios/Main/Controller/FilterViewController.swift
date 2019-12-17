//
//  FilterViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/16/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import BEMCheckBox
import Cosmos

class FilterViewController: UIViewController {
    @IBOutlet weak var filterBackGround: UIImageView!{
        didSet{
            self.filterBackGround.layer.cornerRadius = 15
            self.filterBackGround.layer.borderWidth = 2
            self.filterBackGround.layer.borderColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        }
    }
    @IBOutlet weak var logoBackGround: UIImageView!{
        didSet{
            self.logoBackGround.layer.cornerRadius = self.logoBackGround.frame.width/2
            self.logoBackGround.layer.borderWidth = 2
            self.logoBackGround.layer.borderColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        }
    }
    @IBOutlet var filterOptions: [BEMCheckBox]!{
        didSet{
            checkStyle(BECheckBoxItmeArray: self.filterOptions)
        }
    }
    @IBOutlet weak var filterRate: CosmosView!
    @IBOutlet weak var submitButton: UIButton!{
        didSet{
            self.submitButton.layer.cornerRadius = self.submitButton.frame.height/2
        }
    }
    @IBOutlet weak var filterBackView: UIView!
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func checkStyle(BECheckBoxItmeArray: [BEMCheckBox]){
        for i in BECheckBoxItmeArray.indices{
            BECheckBoxItmeArray[i].onAnimationType = .bounce
            BECheckBoxItmeArray[i].offAnimationType = .bounce
        }
    }
    
}
