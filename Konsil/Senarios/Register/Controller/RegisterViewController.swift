//
//  RegisterViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/16/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import BEMCheckBox
class RegisterViewController: UIViewController {

    @IBOutlet weak var name: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.name)
        }
    }
    @IBOutlet weak var phone: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.phone)
        }
    }
    @IBOutlet weak var email: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.email)
        }
    }
    @IBOutlet weak var password: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.password)
        }
    }
    @IBOutlet weak var registerButton: UIButton!{
        didSet{
            self.registerButton.layer.cornerRadius = self.registerButton.frame.height/2
        }
    }
    @IBOutlet weak var checkBox: BEMCheckBox!{
        didSet{
            self.checkBox.boxType = .square
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func registerWithTwitter(_ sender: UIButton) {
    }
    @IBAction func registerWithGoogle(_ sender: UIButton) {
    }
    @IBAction func registerWithFacebook(_ sender: UIButton) {
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToMain", sender: self)
    }
    
    @IBAction func acceptAllTermsAndConditions(_ sender: BEMCheckBox) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToMain" {
            let vc = segue.destination as! MainNavigationController
            vc.modalPresentationStyle = .fullScreen
        }
    }
}
