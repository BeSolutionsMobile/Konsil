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
    @IBOutlet weak var backButton: UIButton!{
        didSet{
            backButton.setImage(UIImage(named: "leftArrow".localized), for: .normal)
        }
    }
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
        print(dID)
        //        if checkBox.on == true {
        //            DispatchQueue.main.async { [weak self] in
        //                APIClient.register(name: self?.name.text ?? "", email: self?.email.text ?? "", password: self?.password.text ?? "", phone: self?.phone.text ?? "", image_url: "", platform: 3, lang: "Lang".localized, mobile_tokken: "NNNNN") { (Result) in
        //                    switch Result {
        //                    case.success(let response):
        //                        print(response)
        //                    case .failure(let error):
        //                        print("error duo")
        //                        print(error.localizedDescription)
        //                    }
        //                }
        //            }
        //        } else {
        //            Alert.show("Error", massege: "Please accept our terms and conditions then try again".localized, context: self)
        //        }
        
        if checkBox.on == true {
            let validate = validateAllFields()
            if validate == true {
                print("good")
            } else {
                print("No")
            }
        } else {
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
            if password.text!.count < 6 {
                password.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            }
            if let mail = email.text {
                let valied = isValidEmail(mail)
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
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
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
