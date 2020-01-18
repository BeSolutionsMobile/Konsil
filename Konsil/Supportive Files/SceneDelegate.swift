//
//  SceneDelegate.swift
//  Konsil
//
//  Created by mac on 12/15/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import BiometricAuthentication
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        let launchedBefore = UserDefaults.standard.bool(forKey: Key.launchedBefore)
          if launchedBefore  {
          } else {
              UserDefaults.standard.set(true, forKey: Key.launchedBefore)
              UserDefaults.standard.synchronize()
              let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
              let vc = mainStoryboard.instantiateViewController(withIdentifier: "Walkthrough1") as! Walkthrough1ViewController
            self.window!.rootViewController = vc
            self.window!.makeKeyAndVisible()

          }
//        UIApplication.shared.statusBarUIView?.backgroundColor = #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 1)

    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
//            BioMetricAuthenticator.authenticateWithBioMetrics(reason: "", fallbackTitle: "Authinticatation Failed\n Enter email and password") { (Result) in
//                    switch Result {
//                    case .success(let ressponse):
//                        print(ressponse)
//                        print("pass")
//                    case .failure(let error):
//                        print("error")
//                        switch error {
//                        case .fallback:
//                            print("fallbackPressed")
//                        default:
//                            break
//                    }
//                }
    }
    

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        let biometricAuth = UserDefaults.standard.bool(forKey: Key.prefereBiometricAuth)

        if biometricAuth {
            let topController = self.window?.rootViewController?.topViewController()
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let fingerPrintVC = storyBoard.instantiateViewController(identifier: "Lock") as! FingerPrintViewController

            fingerPrintVC.modalPresentationStyle = .overFullScreen
            topController?.present(fingerPrintVC, animated: true, completion: nil)
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
}
