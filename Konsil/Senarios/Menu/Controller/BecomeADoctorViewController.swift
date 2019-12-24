//
//  BecomeADoctorViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/15/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import SideMenu
class BecomeADoctorViewController: UIViewController {
    @IBOutlet weak var imageBackView: UIView!{
        didSet{
            imageBackView.layer.cornerRadius = imageBackView.frame.width/2
            imageBackView.layer.borderColor = UIColor.gray.cgColor
            imageBackView.layer.borderWidth = 3
        }
    }
    @IBOutlet weak var addImage: UIImageView!{
        didSet{
            addImage.layer.cornerRadius = addImage.frame.width/2
            addImage.layer.borderColor = #colorLiteral(red: 0.8985823989, green: 0.9336386919, blue: 0.9438558221, alpha: 1)
            addImage.layer.borderWidth = 4
        }
    }
    @IBOutlet weak var addName: UITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.addName, color: #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1) , radius: self.addName.frame.height/2)
        }
    }
    @IBOutlet weak var addEmail: UITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.addEmail, color: #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1) , radius: self.addEmail.frame.height/2)
        }
    }
    @IBOutlet weak var addPassword: UITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.addPassword, color: #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1) , radius: self.addPassword.frame.height/2)
        }
    }
    @IBOutlet weak var addPhone: UITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.addPhone, color: #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1) , radius: self.addPhone.frame.height/2)
        }
    }
    @IBOutlet weak var submitBut: UIButton!{
        didSet{
            submitBut.layer.cornerRadius = submitBut.frame.height / 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
    }
    
    @IBAction func addImage(_ sender: UIButton) {
    }
    
    @IBAction func requestButPressed(_ sender: UIButton) {
    }
    
    
}
