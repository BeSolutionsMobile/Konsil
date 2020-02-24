//
//  FingerPrintViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 1/12/20.
//  Copyright © 2020 begroup. All rights reserved.
//

import UIKit
import BiometricAuthentication

class FingerPrintViewController: UIViewController {
    
    @IBOutlet weak var fingerPrintImage: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var skipBut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func skip(_ sender: UIButton) {
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
        BioMetricAuthenticator.authenticateWithBioMetrics(reason: "") { (Result) in
            switch Result {
            case .success(_):
                print("Success")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
