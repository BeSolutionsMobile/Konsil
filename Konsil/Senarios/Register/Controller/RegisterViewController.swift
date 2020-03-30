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
import FBSDKLoginKit
import GoogleSignIn
import SafariServices
import SwiftyGif

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
    @IBOutlet weak var logoImagrView: UIImageView!
    
    
    let facebookManger = LoginManager()
    let googleManger = GIDSignIn.sharedInstance()
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGoogleSginIn()
        logoGifImageSetUp()
    }
    
    //MARK:- IBActions
    @IBAction func backButPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        guard let dID = AppDelegate.token else { return }
        let validate = validateAllFields()
        let validatedMail = email.isValidEmail(email.text ?? "")
        if validate == true , validatedMail ,checkBox.on {
            self.startAnimation()
            DispatchQueue.main.async { [weak self] in
                APIClient.register(name: self?.name.text ?? "", email: self?.email.text ?? "", password: self?.password.text ?? "", phone: self?.phone.text ?? "", image_url: "", platform: 3, lang: "Lang".localized, mobile_tokken: dID) {  (Result ,Status)  in
                    switch Result {
                    case.success(let response):
                        if Status == 200 {
                            UserDefaults.standard.set(false, forKey: Key.social)
                            UserDefaults.standard.set(true, forKey: Key.loged)
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
                        Alert.show("Failed".localized, massege: "email already exists".localized, context: self!)
                    case 500:
                        Alert.show("Failed".localized, massege: "something went wrong".localized, context: self!)
                    default:
                        break
                    }
                }
            }
        }else {
            if !checkBox.on {
                Alert.show("Error".localized, massege: "Please accept our terms and conditions then try again".localized, context: self)
                
            }
        }
        
    }
    
    @IBAction func termsOfUse(_ sender: UIButton) {
        let path = "https://www.konsilmed.com/terms"
        guard let terms = URL(string: path) else {return}
        let safariVC = SFSafariViewController(url: terms)
        self.present(safariVC, animated: true, completion: nil)
    }
    
    @IBAction func privacyPolicy(_ sender: UIButton) {
        let path = "https://www.konsilmed.com/privacy"
        guard let policyURL = URL(string: path) else {return}
        let safariVC = SFSafariViewController(url: policyURL)
        self.present(safariVC, animated: true, completion: nil)
        
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
        if checkBox.on {
            googleManger?.signIn()
        } else {
            Alert.show("Error".localized, massege: "Please accept our terms and conditions then try again".localized, context: self)
        }
    }
    @IBAction func registerWithFacebook(_ sender: UIButton) {
        if checkBox.on {
            let permisions = ["email"]
            facebookManger.logIn(permissions: permisions, from: self) {[weak self] (result, error) in
                if error != nil {
                    Alert.show("Error".localized, massege: error?.localizedDescription ?? "", context: self!)
                    return
                }
                if result != nil {
                    if result?.isCancelled ?? true {
                    } else {
                        self?.fetchProfile()
                        self?.startAnimation()
                    }
                }
            }
        } else {
            Alert.show("Error".localized, massege: "Please accept our terms and conditions then try again".localized, context: self)
        }
        
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

//MARK:- Facebook Login
extension RegisterViewController {
    func fetchProfile(){
        let prametters = ["fields":"email, first_name, last_name ,picture.type(large)"]
        GraphRequest(graphPath: "me", parameters: prametters).start {[weak self] (connection, result, error) in
            if error != nil {
                print(error?.localizedDescription)
                self?.stopAnimation()
                return
            }
            if let userData = result as? Dictionary<String, Any> {
                if let email = userData["email"] as? String , let first_name = userData["first_name"] as? String ,let last_name = userData["last_name"] as? String , let id = userData["id"] as? String {
                    
                    let fullName = first_name + " " + last_name
                    var image: String?
                    
                    if let picture = userData["picture"] as? Dictionary<String, Any> , let data = picture["data"] as? Dictionary<String, Any> {
                        image = data["url"] as? String
                    }
                    self?.registerToKonsilAPI(email: email, password: id, image: image ?? "no Image", name: fullName)
                }
            }
        }
    }
    
    //MARK:- Register To Konsil
    func registerToKonsilAPI(email: String ,password: String ,image: String ,name: String){
        if let token = AppDelegate.token {
            let lang = "Lang".localized
            DispatchQueue.main.async {[weak self] in
                APIClient.register(name: name, email: email, password: password, phone: "", image_url: image, platform: 3, lang: lang, mobile_tokken: token) { (result, status) in
                    print(status)
                    switch result {
                    case .success(let response):
                        print(response)
                        if status == 200 {
                            UserDefaults.standard.set(password, forKey: Key.pass)
                            UserDefaults.standard.set(true, forKey: Key.social)
                            UserDefaults.standard.set(true, forKey: Key.loged)
                            Shared.user = response.userInfo
                            UserDefaults.standard.set(response.token as String, forKey: Key.authorizationToken)
                            self?.backView.isHidden = false
                            self?.backView.isUserInteractionEnabled = true
                            self?.BlurView(view: self!.animationView)
                        }
                    case.failure(let error):
                        print(error.localizedDescription)
                        self?.loginToKonsilAPI(email: email, password: password, name: name, image: image)
                    }
                }
            }
        }
    }
    
    //MARK:- Login To Konsil
    func loginToKonsilAPI(email: String ,password: String ,name: String ,image: String){
        if let token = AppDelegate.token {
            DispatchQueue.main.async { [weak self] in
                APIClient.login(email: email, password: password, mobile_tokken: token) { (result, status) in
                    self?.stopAnimation()
                    print(status)
                    switch result {
                    case .success(let response):
                        print(response)
                        if status == 200 {
                            UserDefaults.standard.set(password, forKey: Key.pass)
                            UserDefaults.standard.set(true, forKey: Key.social)
                            UserDefaults.standard.set(true, forKey: Key.loged)
                            Shared.user = response.userInfo
                            UserDefaults.standard.set(response.token as String, forKey: Key.authorizationToken)
                            self?.backView.isHidden = false
                            self?.backView.isUserInteractionEnabled = true
                            self?.BlurView(view: self!.animationView)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        switch status  {
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
            }
        }
    }
}

//MARK:- Google Sgin In
extension RegisterViewController: GIDSignInDelegate {
    
    func setupGoogleSginIn(){
        GIDSignIn.sharedInstance().clientID = "30414761383-5g2d3tsuof784onfl67el1bhsrhk0ni2.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        //        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        // Perform any operations on signed in user here.
        let userId = user.userID      // For client-side use only!
        let fullName = user.profile.name
        let email = user.profile.email
        startAnimation()
        registerToKonsilAPI(email: email ?? "", password: userId ?? "", image: "no Image", name: fullName ?? "")
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
    }
}

//MARK:- GIF Image
extension RegisterViewController: SwiftyGifDelegate {
    func logoGifImageSetUp(){
        logoImagrView.delegate = self
        do {
            let gif = try UIImage(gifName: "anim.gif")
            logoImagrView.setGifImage(gif)
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func gifDidLoop(sender: UIImageView) {
        sender.stopAnimatingGif()
    }

}
