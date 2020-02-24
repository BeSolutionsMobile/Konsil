//
//  RegisterViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/16/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import BEMCheckBox
import MOLH
import NVActivityIndicatorView

class RegisterViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var backButton: UIButton!{
        didSet{
            backButton.setImage(UIImage(named: "leftArrow".localized), for: .normal)
        }
    }
    
    @IBOutlet weak var twitter: UIButton!{
        didSet{
            Rounded.roundButton(button: twitter, radius: twitter.frame.size.height/2)
        }
    }
    @IBOutlet weak var facebook: UIButton!{
        didSet{
            Rounded.roundButton(button: facebook, radius: facebook.frame.size.height/2)
        }
    }
    @IBOutlet weak var google: UIButton!{
        didSet{
            Rounded.roundButton(button: google, radius: google.frame.size.height/2)
        }
    }
    @IBOutlet weak var name: RegisterTextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.name, borderColor: UIColor.gray.cgColor, radius: self.name.frame.height/2)
            name.forceSwitchingRegardlessOfTag = true
            self.name.delegate = self
        }
    }
    @IBOutlet weak var phone: RegisterTextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.phone, borderColor: UIColor.gray.cgColor, radius: self.phone.frame.height/2)
            phone.forceSwitchingRegardlessOfTag = true
            self.phone.delegate = self
        }
    }
    @IBOutlet weak var email: RegisterTextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.email, borderColor: UIColor.gray.cgColor, radius: self.email.frame.height/2)
            email.forceSwitchingRegardlessOfTag = true
            self.email.delegate = self
        }
    }
    @IBOutlet weak var password: RegisterTextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.password, borderColor: UIColor.gray.cgColor, radius: self.password.frame.height/2)
            password.forceSwitchingRegardlessOfTag = true
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
    @IBOutlet weak var animationView: NVActivityIndicatorView!{
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
    @IBOutlet weak var socialStackView: UIStackView!{
        didSet{
            if Shared.currentDevice == .pad {
                NSLayoutConstraint.deactivate(constraints)
                let widthConstraint = self.socialStackView.widthAnchor.constraint(equalToConstant: 400)
                NSLayoutConstraint.activate([widthConstraint])
            }
        }
        
    }
    @IBOutlet weak var backView: UIView!
    @IBOutlet var constraints: [NSLayoutConstraint]!
    
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK:- Change Status Bar To Dark
    //    override var preferredStatusBarStyle: UIStatusBarStyle {
    //        return .darkContent
    //    }
    
    //MARK:- IBActions
    
    @IBAction func backButPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "BackToLogin", sender: self)
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        guard let dID = AppDelegate.token else { return }
        if checkBox.on == true {
            let validate = validateAllFields()
            let validatedMail = email.isValidEmail(email.text ?? "")
            if validate == true , validatedMail == true{
                self.startAnimation()
                DispatchQueue.main.async { [weak self] in
                    APIClient.register(name: self?.name.text ?? "", email: self?.email.text ?? "", password: self?.password.text ?? "", phone: self?.phone.text ?? "", image_url: "", platform: 3, lang: "Lang".localized, mobile_tokken: dID) {  (Result ,Status)  in
                        switch Result {
                        case.success(let response):
                            if Status >= 200 && Status < 300 {
                                Shared.user = response.userInfo
                                UserDefaults.standard.set(response.token as String, forKey: Key.authorizationToken)
                                self?.backView.isHidden = false
                                self?.backView.isUserInteractionEnabled = true
                                self?.BlurView(view: self!.animationView)
                            }
                        case .failure(let error):
                            self?.stopAnimation()
                            print(error.localizedDescription)
                        }
                        switch Status {
                        case 402:
                            Alert.show("", massege: "email already exists".localized, context: self!)
                        case 500:
                            Alert.show("Failed".localized, massege: "something went wrong".localized, context: self!)
                        default:
                            break
                        }
                    }
                }
            }
        } else {
            self.stopAnimation()
            Alert.show("Error".localized, massege: "Please accept our terms and conditions then try again".localized, context: self)
        }
    }
    
    // Check All TextFields
    func validateAllFields() ->Bool {
        if name.text!.count < 3 || email.text!.isEmpty || phone.text!.count < 10 || password.text!.count < 6 {
            if name.text!.count < 3  {
                name.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            }
            if phone.text!.count < 10 {
                phone.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            }
            if password.text!.count < 8 {
                password.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            }
            if let mail = email.text {
                let valied = email.isValidEmail(mail)
                if valied == false {
                    email.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
                }
            }
            if email.text!.count < 5 {
                email.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            }
            return false
            
        } else {
            name.layer.borderColor = UIColor.gray.cgColor
            phone.layer.borderColor = UIColor.gray.cgColor
            password.layer.borderColor = UIColor.gray.cgColor
            email.layer.borderColor = UIColor.gray.cgColor
            return true
        }
    }
    
    // Check Email Validation
    
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
    
    @IBAction func acceptAllTermsAndConditions(_ sender: BEMCheckBox) {
    }
    @IBAction func registerWithTwitter(_ sender: UIButton) {
    }
    
    @IBAction func registerWithGoogle(_ sender: UIButton) {
    }
    @IBAction func registerWithFacebook(_ sender: UIButton) {
    }
    
    // MARK:- Revert TextField's Border Color To Normal When Selected Or Text Changed
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
    
    //MARK:- Make Blury Background For The Animation
    func BlurView(view: UIView){
        if animationView.isAnimating {
            animationView.stopAnimating()
        }
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
