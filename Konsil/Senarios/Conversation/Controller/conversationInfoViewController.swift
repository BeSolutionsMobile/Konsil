//
//  conversationInfoViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/18/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

class conversationInfoViewController: UIViewController {

    @IBOutlet weak var link: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var conversationStatus: UILabel!
    @IBOutlet var redDot: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundDots()
    }
    
    func roundDots(){
        for i in redDot.indices {
            redDot[i].layer.cornerRadius = redDot[i].frame.width/2
        }
    }

}
