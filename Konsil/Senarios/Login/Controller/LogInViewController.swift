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
import Network
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
            Rounded.roundedCornerTextField(textField: self.passwordTF, borderColor: UIColor.gray.cgColor, radius: self.passwordTF.frame.height/2)
            self.passwordTF.delegate = self
        }
    }
    @IBOutlet weak var emailTF: UITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.emailTF, borderColor: UIColor.gray.cgColor, radius: self.emailTF.frame.height/2)
            self.emailTF.delegate = self
        }
    }
    @IBOutlet weak var socialStackView: UIStackView!{
        didSet{
            if Shared.currentDevice == .pad {
                NSLayoutConstraint.deactivate(constraints)
                let widthConstraint = self.socialStackView.widthAnchor.constraint(equalToConstant: 400)
                NSLayoutConstraint.activate([widthConstraint])
            }
        }
    }
    @IBOutlet var constraints: [NSLayoutConstraint]!
    @IBOutlet var redDot: [UIView]!{
        didSet{
            Rounded.roundedDots(Dots: redDot)
        }
    }
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
    }
    
    
    //MARK:- IBActions
    @IBAction func logInWithTwitter(_ sender: UIButton) {
    }
    @IBAction func logInWithGoogle(_ sender: UIButton) {
    }
    @IBAction func logInWithFacebook(_ sender: UIButton) {
    }
    @IBAction func registerPressed(_ sender: UIButton) {
        if #available(iOS 13.0, *) {
            if let vc = storyboard?.instantiateViewController(identifier: "Register") as? RegisterViewController {
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        let isBiometricAuthEnabled = allowBiometricAuth.on ? true : false
        UserDefaults.standard.set(isBiometricAuthEnabled, forKey: Key.prefereBiometricAuth)
        backView.isHidden = false
        backView.isUserInteractionEnabled = true
        BlurView(view: animationView)
    }
    
    @IBAction func biometricAuthChecked(_ sender: BEMCheckBox) {
        let isBiometricAuthEnabled = allowBiometricAuth.on ? true : false
        UserDefaults.standard.set(isBiometricAuthEnabled, forKey: Key.prefereBiometricAuth)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToMain" {
            let vc = segue.destination as! MainNavigationController
            vc.modalPresentationStyle = .fullScreen
        }
    }
    
    //MARK:- Make Blur View For Animation
    func BlurView(view: UIView){
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = view.bounds
        view.addSubview(blurView)
        view.isHidden = false
        let animation = Shared.showLottie(view: blurView.contentView, fileName: Animations.success , contentMode: .scaleAspectFit)
        blurView.contentView.addSubview(animation)
        view.addSubview(blurView)
        animation.play { (finished) in
            if finished == true {
                self.performSegue(withIdentifier: "GoToMain", sender: self)
            }
        }
    }
    
    //MARK:- Chaneg Status Bar To Dark
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        if #available(iOS 13.0, *) {
//            return .darkContent
//        } else {
//            
//        }
//    }
    
}
