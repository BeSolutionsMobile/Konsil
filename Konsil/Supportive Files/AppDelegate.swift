//
//  AppDelegate.swift
//  UsingFiles
//
//  Created by Tim Richardson on 10/05/2018.
//  Copyright © 2018 iOS Mastery. All rights reserved.
//

import UIKit
import MOLH
import Firebase
import BiometricAuthentication
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , MOLHResetable {
    
    var window: UIWindow?
    static var token:String?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        MOLH.shared.activate(true)
        MOLHLanguage.setDefaultLanguage("en")
        FirebaseApp.configure()
        
        IQKeyboardManager.shared.enable = true
        
        retriveToken()
        
        let didLunchedBefore = UserDefaults.standard.bool(forKey: Key.launchedBefore)
        if !didLunchedBefore {
            UserDefaults.standard.set(true, forKey: Key.launchedBefore)
            UserDefaults.standard.synchronize()
            let storboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storboard.instantiateViewController(withIdentifier: "Walkthrough1") as? Walkthrough1ViewController {
                window?.makeKeyAndVisible()
                window?.rootViewController = vc
            }
        }
        
        PayPalMobile.initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction: "AaQMeV82vGXt0gXLbfEtwNtRMr12vk5JJxSwPm-u5E5YGNfwcyXvg_FQ88aVz54kit5OZzUh5pmZkQKs" ,PayPalEnvironmentSandbox: "AdQh917Bn6uR8ZhbXDksThG5AA1aaOSYeTBhfemfhKzXHYkeIhb1txnp4d2h_5aTOAVS5sFGClz4dTs9"] )
        
        checkBioAuth()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        UserDefaults.standard.set(false, forKey: Key.loged)
    }
    
    func reset() {
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let stry = UIStoryboard(name: "Main", bundle: nil)
        rootviewcontroller.rootViewController = stry.instantiateViewController(withIdentifier: "MainNavigation")
    }
    
    // Get Device Token
    func retriveToken() {
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                AppDelegate.token = result.token
                //                print("Remote instance ID token: \(result.token)")
            }
        }
    }
    
    
    
    func checkBioAuth(){
        let biometricAuth = UserDefaults.standard.bool(forKey: Key.prefereBiometricAuth)
        print(biometricAuth)
        if biometricAuth {
            let storboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storboard.instantiateViewController(withIdentifier: "Lock") as? FingerPrintViewController {
                window?.makeKeyAndVisible()
                window?.rootViewController = vc
            }
        }
    }

//    func checkBioAuth(){
//        let biometricAuth = UserDefaults.standard.bool(forKey: Key.prefereBiometricAuth)
//        print(biometricAuth)
//        if biometricAuth {
//            let topController = self.window?.rootViewController?.topViewController()
//
//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            if let fingerPrintVC = storyBoard.instantiateViewController(withIdentifier: "Lock") as? FingerPrintViewController {
//                fingerPrintVC.modalPresentationStyle = .overFullScreen
//                topController?.present(fingerPrintVC, animated: true, completion: nil)
//            }
//        }
//    }

}

