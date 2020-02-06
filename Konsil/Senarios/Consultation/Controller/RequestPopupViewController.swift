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
            Rounded.roundedImage(imageView: backgroundImage, radius: 10, borderColor: UIColor.gray.cgColor, borderWidth: 2)
        }
    }
    @IBOutlet weak var logoImg: UIImageView!{
        didSet{
            Rounded.roundedImage(imageView: logoImg, radius: self.logoImg.frame.height/2, borderColor: UIColor.gray.cgColor, borderWidth: 2)
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
