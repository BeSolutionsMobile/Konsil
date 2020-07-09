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
import Stripe
import UserNotifications
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , MOLHResetable {
    
    var window: UIWindow?
    static var token:String?
    let gcmMessageIDKey = "gcm.message_id"
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        MOLH.shared.activate(true)
        MOLHLanguage.setDefaultLanguage("en")
        
        Messaging.messaging().delegate = self
        
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        
        
        FirebaseApp.configure()
        firstTimeGettingToken()
        
        IQKeyboardManager.shared.enable = true
        
        Stripe.setDefaultPublishableKey("pk_live_naoQPab0j0XZPhG3cmryN3Qk003AB10ONp")
        
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
        
        //        PayPalMobile.initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction: "AaQMeV82vGXt0gXLbfEtwNtRMr12vk5JJxSwPm-u5E5YGNfwcyXvg_FQ88aVz54kit5OZzUh5pmZkQKs" ,PayPalEnvironmentSandbox: "AdQh917Bn6uR8ZhbXDksThG5AA1aaOSYeTBhfemfhKzXHYkeIhb1txnp4d2h_5aTOAVS5sFGClz4dTs9"] )
        
        checkBioAuth()
        
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        return true
    }
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {

        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )

    }
    
    
    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    // [END receive_message]
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved (FCM): \(deviceToken)")
        
        // With swizzling disabled you must set the APNs token here.
        // Messaging.messaging().apnsToken = deviceToken
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
                print("Remote instance ID token: \(result.token)")
            }
        }
    }
    
    func firstTimeGettingToken() {
        InstanceID.instanceID().instanceID {[weak self] (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                AppDelegate.token = result.token
                print("Remote instance ID token: \(result.token)")
                self?.updateToken()
            }
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        updateToken()
    }
    
    func updateToken(){
        print("Active1")
        if let token = AppDelegate.token {
            print("Active")
//            let userId = UserDefaults.standard.string(forKey: "ss")
            if AppDelegate.token != nil {
                if AppDelegate.token != token {
                    AppDelegate.token = token
                    DispatchQueue.global().async { [weak self] in
                        self?.retriveToken()
                        //                        APIClient.updateToken(token: token, user_id: user_id ?? "") { (result, status) in
                        //                            switch result {
                        //                            case .success(let response):
                        //                                print(response)
                        //                            case .failure(let error):
                        //                                print(error.localizedDescription)
                        //                            }
                        //                        }
                    }
                }
            } else {
                AppDelegate.token = token
                DispatchQueue.global().async { [weak self] in
                    self?.retriveToken()
                    //                    APIClient.updateToken(token: token, user_id: user_id ?? "") { (result, status) in
                    //                        switch result {
                    //                        case .success(let response):
                    //                            print(response)
                    //                        case .failure(let error):
                    //                            print(error.localizedDescription)
                    //                        }
                    //                    }
                }
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
}


// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler()
    }
}
// [END ios_10_message_handling]

extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
    
    
    //    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
    //        print("Received data message: \(remoteMessage.appData)")
    //    }
    
    
    // [END ios_10_data_message]
}
