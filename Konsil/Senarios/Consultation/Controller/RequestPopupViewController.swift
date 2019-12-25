//
//  RequestPopupViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/17/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

class RequestPopupViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!{
        didSet{
            self.backgroundImage.layer.cornerRadius = 10
            self.backgroundImage.layer.borderWidth = 2
            self.backgroundImage.layer.borderColor = UIColor.gray.cgColor
        }
    }
    @IBOutlet weak var logoImg: UIImageView!{
        didSet{
            self.logoImg.layer.cornerRadius = self.logoImg.frame.height/2
            self.logoImg.layer.borderWidth = 2
            self.logoImg.layer.borderColor = UIColor.gray.cgColor
        }
    }
    @IBOutlet weak var popUpTitle: UILabel!
    @IBOutlet weak var popUpDetails: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
}
