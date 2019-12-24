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
    
    //MARK:- IBOutlets
    @IBOutlet weak var name: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.name, color: UIColor.darkGray.cgColor, radius: self.name.frame.height/2)
        }
    }
    @IBOutlet weak var phone: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.phone, color: UIColor.darkGray.cgColor, radius: self.phone.frame.height/2)
        }
    }
    @IBOutlet weak var email: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.email, color: UIColor.darkGray.cgColor, radius: self.email.frame.height/2)
        }
    }
    @IBOutlet weak var password: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.password, color: UIColor.darkGray.cgColor, radius: self.password.frame.height/2)
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
    @IBOutlet var redDot: [UIView]!
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        Rounded.roundedDots(Dots: redDot)
    }
    
    //MARK:- Change Status Bar To Dark
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    //MARK:- IBActions
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
    
    //MARK:- Prepare For Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToMain" {
            let vc = segue.destination as! MainNavigationController
            vc.modalPresentationStyle = .fullScreen
        }
    }
}
