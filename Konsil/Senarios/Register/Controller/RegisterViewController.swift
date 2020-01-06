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
            Rounded.roundedCornerTextField(textField: self.name, borderColor: UIColor.gray.cgColor, radius: self.name.frame.height/2)
            self.name.delegate = self
        }
    }
    @IBOutlet weak var phone: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.phone, borderColor: UIColor.gray.cgColor, radius: self.phone.frame.height/2)
            self.phone.delegate = self
        }
    }
    @IBOutlet weak var email: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.email, borderColor: UIColor.gray.cgColor, radius: self.email.frame.height/2)
            self.email.delegate = self
        }
    }
    @IBOutlet weak var password: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.password, borderColor: UIColor.gray.cgColor, radius: self.password.frame.height/2)
            self.password.delegate = self
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
    @IBOutlet weak var animationView: UIView!{
        didSet{
            self.animationView.layer.cornerRadius = 10
            self.animationView.clipsToBounds = true
        }
    }
    @IBOutlet var redDot: [UIView]!{
        didSet{
            Rounded.roundedDots(Dots: redDot)
        }
    }
    @IBOutlet weak var backView: UIView!
    
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func backButPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "BackToLogin", sender: self)
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if checkBox.on == true {
            backView.isHidden = false
            backView.isUserInteractionEnabled = true
            BlurView(view: animationView)
        } else {
            Alert.show("Error", massege: "Pleas accept our terms and conditions then try again", context: self)
        }
    }
    @IBAction func acceptAllTermsAndConditions(_ sender: BEMCheckBox) {
        print("T & C Accepted")
    }
    
    //MARK:- Prepare For Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToMain" {
            let vc = segue.destination as! MainNavigationController
            vc.modalPresentationStyle = .fullScreen
        } else if segue.identifier == "BackToLogin" {
            let vc = segue.destination as! LogInViewController
            vc.modalPresentationStyle = .fullScreen
        }
    }
    
    func BlurView(view: UIView){
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = view.bounds
        view.addSubview(blurView)
        view.isHidden = false
        let animation = Shared.showLottie(view: blurView.contentView, fileName: "success", contentMode: .scaleAspectFit)
        blurView.contentView.addSubview(animation)
        view.addSubview(blurView)
        animation.play { (finished) in
            if finished == true {
                self.performSegue(withIdentifier: "GoToMain", sender: self)
            }
        }
        
    }
    
}
