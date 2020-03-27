//
//  FingerPrintViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 1/12/20.
//  Copyright © 2020 begroup. All rights reserved.
//

import UIKit
import BiometricAuthentication
import NVActivityIndicatorView

class FingerPrintViewController: UIViewController {
    
    @IBOutlet weak var tryAgian: UIButton!
    @IBOutlet weak var loginBut: UIButton!{
        didSet{
            Rounded.roundButton(button: self.loginBut, radius: self.loginBut.frame.size.height/2)
        }
    }
    @IBOutlet weak var fingerPrintImage: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var skipBut: UIButton!
    @IBOutlet weak var authImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForBioType()
        bio()
    }
    
    func checkForBioType(){
        if BioMetricAuthenticator.shared.faceIDAvailable() {
            authImage.image = UIImage(named: "FaceID")
        } else if BioMetricAuthenticator.shared.touchIDAvailable() {
            authImage.image = UIImage(named: "TouchID")
        } else {
            
        }
    }
    
    @IBAction func TryAgain(_ sender: UIButton) {
        bio()
    }
    
    @IBAction func backToLogin(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogIn") as? LogInViewController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func success(){
        tryAgian.isEnabled = false
        loginBut.isEnabled = false
        fingerPrintImage.image = nil
        let animationView = Shared.showLottie(view: backView, fileName: "Unlock", contentMode: .scaleAspectFit)
        animationView.animationSpeed = 1.5
        
        animationView.play {[weak self] (finished) in
            if finished == true {
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "MainNavigation") as! MainNavigationController
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true, completion: nil)
            }
        }
    }
        
    func bio(){        
        BioMetricAuthenticator.authenticateWithBioMetrics(reason: "") {[weak self] (Result) in
            switch Result {
            case .success( _):
                self?.loginRequset()
            case .failure(let error):
                self?.tryAgian.isHidden = false
                switch error {
                // device does not support biometric (face id or touch id) authentication
                case .biometryNotAvailable:
                    Alert.backToLogin("Error".localized, massege: "NoTouchID".localized, context: self!)
                    
                // No biometry enrolled in this device, ask user to register fingerprint or face
                case .biometryNotEnrolled:
//                    self?.showGotoSettingsAlert(message: error.message())
                    Alert.show("Failed".localized, massege: "NoTouchID".localized , context: self!)
                    
                // show alternatives on fallback button clicked
                case .fallback:
                    if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "LogIn") as? LogInViewController {
                        self?.present(vc, animated: true, completion: nil)
                    }
                    
                    // Biometry is locked out now, because there were too many failed attempts.
                // Need to enter device passcode to unlock.
                case .biometryLockedout:
                    print("locked")
                    
                // do nothing on canceled by system or user
                case .canceledBySystem, .canceledByUser:
                    break
                    
                // show error for any other reason
                default:
                    Alert.backToLogin("Failed".localized, massege: "Touch/Face ID Do Not Match".localized, context: self!)
                }
            }
        }
    }
    
    func loginRequset(){
        if let mail = UserDefaults.standard.string(forKey: Key.mail) ,let pass = UserDefaults.standard.string(forKey: Key.pass ) ,let tokken = AppDelegate.token {
            self.startAnimating()
            DispatchQueue.global().async {[weak self] in
                APIClient.login(email: mail, password: pass, mobile_tokken: tokken) { (Result, Status) in
                    self?.stopAnimating()
                    switch Result {
                    case .success(let response):
                        if Status == 200 {
                            Shared.user = response.userInfo
                            self?.success()
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        switch Status {
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
