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
import NVActivityIndicatorView

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
    @IBOutlet weak var animationView: NVActivityIndicatorView!{
        didSet{
            self.animationView.layer.cornerRadius = 10
            self.animationView.clipsToBounds = true
        }
    }
    @IBOutlet weak var twitter: UIButton!{
        didSet{
            Rounded.roundButton(button: self.twitter, radius: self.twitter.frame.size.height/2)
        }
    }
    @IBOutlet weak var gmail: UIButton!{
        didSet{
            Rounded.roundButton(button: self.gmail, radius: self.gmail.frame.size.height/2)
        }
    }
    @IBOutlet weak var facebook: UIButton!{
        didSet{
            Rounded.roundButton(button: self.facebook, radius: self.facebook.frame.size.height/2)
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
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Register") as? RegisterViewController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email = emailTF.text , let password = passwordTF.text , let token = AppDelegate.token , emailTF.text != "" , passwordTF.text != "" , emailTF.isValidEmail(emailTF.text ?? "") {
            startAnimation()
            DispatchQueue.main.async { [weak self] in
                APIClient.login(email: email, password: password , mobile_tokken: token) { (Result,state) in
                    switch Result {
                    case .success(let response):
                        if state >= 200 , state < 300 {
                            self?.setupBioAuth(response: response)
                            self?.backView.isHidden = false
                            self?.backView.isUserInteractionEnabled = true
                            self?.BlurView(view: self!.animationView)
                        }
                    case .failure(let error):
                        self?.stopAnimation()
                        print(state)
                        print(error.localizedDescription)
                        
                    }
                    switch state  {
                    case 406:
                        fallthrough
                    case 401:
                        Alert.show("Failed".localized, massege: "Email or Password is incorrect".localized, context: self!)
                    case 405:
                        Alert.show("Failed".localized, massege: "Email does not exist".localized, context: self!)
                    default:
                        break
                    }
                }
            }
        } else {
            self.stopAnimation()
            if emailTF.text == "" {
                emailTF.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            }else if emailTF.isValidEmail(emailTF.text ?? "" ) == false {
                emailTF.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            }
            if passwordTF.text == "" {
                passwordTF.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            }
        }
    }
    
    func setupBioAuth(response: Login){
        let bioStatus = UserDefaults.standard.bool(forKey: Key.prefereBiometricAuth)
        if bioStatus == true {
            if let mail = emailTF.text ,let pass = passwordTF.text {
                UserDefaults.standard.set(mail, forKey: Key.mail)
                UserDefaults.standard.set(pass, forKey: Key.pass)
            }
        }
        Shared.user = response.userInfo
        UserDefaults.standard.set(response.token as String, forKey: Key.authorizationToken)
        UserDefaults.standard.set(true, forKey: Key.loged)
        print(UserDefaults.standard.bool(forKey: Key.prefereBiometricAuth))
    }
    
    func startAnimation(){
        backView.isUserInteractionEnabled = true
        backView.isHidden = false
        animationView.type = .circleStrokeSpin
        animationView.padding = 25
        animationView.startAnimating()
    }
    
    func stopAnimation(){
        animationView.stopAnimating()
        backView.isHidden = true
        backView.isUserInteractionEnabled = false
    }
    
    @IBAction func textDidChange(_ sender: UITextField) {
        if sender.layer.borderColor != UIColor.gray.cgColor {
            sender.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.layer.borderColor != UIColor.gray.cgColor {
            textField.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    @IBAction func biometricAuthChecked(_ sender: BEMCheckBox) {
        if BioMetricAuthenticator.shared.faceIDAvailable() {
            let isBiometricAuthEnabled = allowBiometricAuth.on ? true : false
            UserDefaults.standard.set(isBiometricAuthEnabled, forKey: Key.prefereBiometricAuth)
        } else if BioMetricAuthenticator.shared.touchIDAvailable(){
            let isBiometricAuthEnabled = allowBiometricAuth.on ? true : false
            UserDefaults.standard.set(isBiometricAuthEnabled, forKey: Key.prefereBiometricAuth)
            print("Touch ID Available")
        } else {
            allowBiometricAuth.on = false
            let isBiometricAuthEnabled = allowBiometricAuth.on ? true : true
            UserDefaults.standard.set(isBiometricAuthEnabled, forKey: Key.prefereBiometricAuth)
            Alert.show("Touch/Face ID not configured".localized, massege: "You Can't Use This Feature Right Now".localized, context: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToMain" {
            let vc = segue.destination as! MainNavigationController
            vc.modalPresentationStyle = .fullScreen
        }
    }
    
    //MARK:- Make Blur View For Animation
    func BlurView(view: UIView){
        if animationView.isAnimating {
            animationView.stopAnimating()
        }
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
