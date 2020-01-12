//
//  FingerPrintViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 1/12/20.
//  Copyright © 2020 begroup. All rights reserved.
//

import UIKit

class FingerPrintViewController: UIViewController {
    
    @IBOutlet weak var fingerPrintImage: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var skipBut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func skip(_ sender: UIButton) {
        fingerPrintImage.image = nil
        let animationView = Shared.showLottie(view: backView, fileName: "Unlock", contentMode: .scaleAspectFit)
        animationView.animationSpeed = 1.5
        
        animationView.play { (finished) in
            if finished == true {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
