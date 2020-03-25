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
import FBSDKLoginKit
import GoogleSignIn

class LogInViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var allowBiometricAuth: BEMCheckBox!{ didSet{ self.allowBiometricAuth.boxType = .square }}
    @IBOutlet weak var logInButton: UIButton!{ didSet{ self.logInButton.layer.cornerRadius = self.logInButton.frame.height/2 }}
    @IBOutlet weak var passwordTF: UITextField!{ didSet{ Rounded.roundedCornerTextField(textField: self.passwordTF, borderColor: UIColor.gray.cgColor, radius: self.passwordTF.frame.height/2)
        self.passwordTF.delegate = self }}
    @IBOutlet weak var emailTF: UITextField!{ didSet{ Rounded.roundedCornerTextField(textField: self.emailTF, borderColor: UIColor.gray.cgColor, radius: self.emailTF.frame.height/2)
        self.emailTF.delegate = self }}
    @IBOutlet weak var socialStackView: UIStackView!{ didSet{
        if Shared.currentDevice == .pad {
            NSLayoutConstraint.deactivate(constraints)
            let widthConstraint = self.socialStackView.widthAnchor.constraint(equalToConstant: 400)
            NSLayoutConstraint.activate([widthConstraint]) }}}
    @IBOutlet var constraints: [NSLayoutConstraint]!
    @IBOutlet var redDot: [UIView]!{ didSet{ Rounded.roundedDots(Dots: redDot) }}
    @IBOutlet weak var animationView: NVActivityIndicatorView!{ didSet{ self.animationView.layer.cornerRadius = 10
        self.animationView.clipsToBounds = true }}
    @IBOutlet weak var twitter: UIButton!{ didSet{ Rounded.roundButton(button: self.twitter, radius: self.twitter.frame.size.height/2) }}
    @IBOutlet weak var gmail: UIButton!{ didSet{ Rounded.roundButton(button: self.gmail, radius: self.gmail.frame.size.height/2) }}
    @IBOutlet weak var facebook: UIButton!{ didSet{ Rounded.roundButton(button: self.facebook, radius: self.facebook.frame.size.height/2) }}
    @IBOutlet weak var backView: UIView!
    
    let facebookManger = LoginManager()
    let googleManger = GIDSignIn.sharedInstance()
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGoogleSginIn()
    }
    
    //MARK:- IBActions
    @IBAction func logInWithTwitter(_ sender: UIButton) {
    }
    @IBAction func logInWithGoogle(_ sender: UIButton) {
        googleManger?.signIn()
    }
    @IBAction func logInWithFacebook(_ sender: UIButton) {
        let permisions = ["email"]
        facebookManger.logIn(permissions: permisions, from: self) {[weak self] (result, error) in
            if error != nil {
                Alert.show("Error".localized, massege: "sssdsd", context: self!)
                return
            }
            if result != nil {
                if result?.isCancelled ?? true {
                } else {
                    self?.fetchProfile()
                }
            }
        }
    }
    @IBAction func registerPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Register") as? RegisterViewController {
            vc.modalPresentationStyle = .fullScreen
            biometricStatus()
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
                        if state == 200 {
                            UserDefaults.standard.set(false, forKey: Key.social)
                            self?.setupBioAuth(response: response ,password: password)
                            self?.backView.isHidden = false
                            self?.backView.isUserInteractionEnabled = true
                            self?.BlurView(view: self!.animationView)
                        }
                    case .failure(let error):
                        self?.stopAnimation()
                        print(error.localizedDescription)
                        
                        switch state  {
                        case 406:
                            fallthrough
                        case 401:
                            Alert.show("Failed".localized, massege: "Email or Password is incorrect".localized, context: self!)
                        case 405:
                            Alert.show("Failed".localized, massege: "Email does not exist".localized, context: self!)
                        default:
                            Alert.show("Error".localized, massege: "Please check your network connection and try again".localized, context: self!)
                        }
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
    
    func setupBioAuth(response: Login ,password: String){
        biometricStatus()
        let bioStatus = UserDefaults.standard.bool(forKey: Key.prefereBiometricAuth)
        if bioStatus == true {
            UserDefaults.standard.set(response.userInfo.email, forKey: Key.mail)
            UserDefaults.standard.set(password, forKey: Key.pass)
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
    
    @IBAction func biometricAuthChecked(_ sender: BEMCheckBox) {
        if BioMetricAuthenticator.shared.faceIDAvailable() {
            biometricStatus()
        } else if BioMetricAuthenticator.shared.touchIDAvailable(){
            biometricStatus()
            print("Touch ID Available")
        } else {
            allowBiometricAuth.on = false
            biometricStatus()
            Alert.show("Touch/Face ID not configured".localized, massege: "You Can't Use This Feature Right Now".localized, context: self)
        }
    }
    
    func biometricStatus(){
        let isBiometricAuthEnabled = allowBiometricAuth.on ? true : false
        UserDefaults.standard.set(isBiometricAuthEnabled, forKey: Key.prefereBiometricAuth)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToMain" {
            let vc = segue.destination as! MainNavigationController
            vc.modalPresentationStyle = .fullScreen
        }
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
}

//MARK:- Facebook Login
extension LogInViewController {
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
                    self?.loginToKonsilAPI(email: email, password: id, name: fullName ,image: image ?? "no Image")
                }
            }
        }
    }
    
    //MARK:- Login To Konsil
    func loginToKonsilAPI(email: String ,password: String ,name: String ,image: String){
        if let token = AppDelegate.token {
            startAnimation()
            DispatchQueue.main.async { [weak self] in
                APIClient.login(email: email, password: password, mobile_tokken: token) { (result, status) in
                    print(status)
                    switch result {
                    case .success(let response):
                        print(response)
                        if status == 200 {
                            UserDefaults.standard.set(true, forKey: Key.social)
                            UserDefaults.standard.set(password, forKey: Key.pass)
                            self?.setupBioAuth(response: response, password: password)
                            self?.backView.isHidden = false
                            self?.backView.isUserInteractionEnabled = true
                            self?.BlurView(view: self!.animationView)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        self?.registerToKonsilAPI(email: email, password: password, image: image, name: name)
                    }
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
                    self?.stopAnimation()
                    switch result {
                    case .success(let response):
                        print(response)
                        if status == 200 {
                            UserDefaults.standard.set(true, forKey: Key.social)
                            UserDefaults.standard.set(password, forKey: Key.pass)
                            self?.backView.isHidden = false
                            self?.backView.isUserInteractionEnabled = true
                            Shared.user = response.userInfo
                            UserDefaults.standard.set(response.token as String, forKey: Key.authorizationToken)
                            UserDefaults.standard.set(true, forKey: Key.loged)
                            self?.BlurView(view: self!.animationView)
                        }
                    case.failure(let error):
                        print(error.localizedDescription)
                        switch status {
                        case 402:
                            Alert.show("Failed".localized, massege: "email already exists".localized, context: self!)
                        case 500:
                            Alert.show("Failed".localized, massege: "something went wrong".localized, context: self!)
                        default:
                            Alert.show("Error".localized, massege: "Please check your network connection and try again".localized, context: self!)
                        }
                    }
                }
            }
        }
    }
}

//MARK:- Google Sgin In
extension LogInViewController: GIDSignInDelegate {
    
    func setupGoogleSginIn() {
        GIDSignIn.sharedInstance().clientID = "30414761383-5g2d3tsuof784onfl67el1bhsrhk0ni2.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self        
        GIDSignIn.sharedInstance()?.presentingViewController = self
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
        
        let userId = user.userID      // For client-side use only!
        let fullName = user.profile.name
        let email = user.profile.email
        loginToKonsilAPI(email: email ?? "", password: userId ?? "", name: fullName ?? "", image: "no Image")
        
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
    }
}
