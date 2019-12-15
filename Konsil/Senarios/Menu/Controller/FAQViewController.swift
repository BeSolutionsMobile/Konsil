//
//  FAQViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/15/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

class FAQViewController: UIViewController {

    @IBOutlet weak var groub1LBL: UILabel!{
        didSet{
            groub1LBL.layer.cornerRadius = groub1LBL.frame.height/2
            groub1LBL.clipsToBounds = true
            
        }
    }
    @IBOutlet weak var groub2LBL: UILabel!{
        didSet{
            groub2LBL.layer.cornerRadius = groub2LBL.frame.height/2
            groub2LBL.clipsToBounds = true
            
        }
    }
    @IBOutlet weak var questtion1: UITextField!
    @IBOutlet weak var question2: UITextField!
    @IBOutlet var questtionAnswers: [UITextField]!
    @IBOutlet var questtion2Answers: [UITextField]!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    

}
