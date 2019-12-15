//
//  BecomeADoctorViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/15/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

class BecomeADoctorViewController: UIViewController {
    @IBOutlet weak var imageBackView: UIView!{
        didSet{
            imageBackView.layer.cornerRadius = imageBackView.frame.width/2
            imageBackView.layer.borderColor = UIColor.lightGray.cgColor
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
    @IBOutlet weak var addName: UITextField!
    @IBOutlet weak var addEmail: UITextField!
    @IBOutlet weak var addPassword: UITextField!
    @IBOutlet weak var addPhone: UITextField!
    @IBOutlet weak var submitBut: UIButton!{
        didSet{
            submitBut.layer.cornerRadius = submitBut.frame.height / 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addImage(_ sender: UIButton) {
    }
    
    @IBAction func requestButPressed(_ sender: UIButton) {
    }
}
