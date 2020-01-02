//
//  LogInViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/16/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import BEMCheckBox
import BiometricAuthentication
class LogInViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var allowBiometricAuth: BEMCheckBox!{
        didSet{
            self.allowBiometricAuth.boxType = .square
        }
    }
    @IBOutlet weak var logInButton: UIButton!{
        didSet{
            self.logInButton.layer.cornerRadius = self.logInButton.frame.height/2
        }
    }
    @IBOutlet weak var passwordTF: UITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.passwordTF, color: UIColor.gray.cgColor, radius: self.passwordTF.frame.height/2)
        }
    }
    @IBOutlet weak var emailTF: UITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.emailTF, color: UIColor.gray.cgColor, radius: self.emailTF.frame.height/2)
        }
    }
    @IBOutlet var redDot: [UIView]!
    @IBOutlet weak var animationView: UIView!{
        didSet{
            self.animationView.layer.cornerRadius = 10
            self.animationView.clipsToBounds = true
        }
    }
    @IBOutlet weak var backView: UIView!
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        Rounded.roundedDots(Dots: redDot)
    }
    
    //MARK:- Chaneg Status Bar To Dark
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    //MARK:- IBActions
    @IBAction func logInWithTwitter(_ sender: UIButton) {
    }
    @IBAction func logInWithGoogle(_ sender: UIButton) {
    }
    @IBAction func logInWithFacebook(_ sender: UIButton) {
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        new(view: animationView)
    }
    @IBAction func biometricAuthChecked(_ sender: BEMCheckBox) {
        Shared.BiometricAuthEnabled = sender.on
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToMain" {
            let vc = segue.destination as! MainNavigationController
            vc.modalPresentationStyle = .fullScreen
        }
    }
    
    func new(view: UIView){
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
