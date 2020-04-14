//
//  Alert.swift
//  Eschoola
//
//  Created by Admin on 6/4/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    static func show(_ title:String, massege:String , context:UIViewController) {
        
        let alert = UIAlertController(title: title, message: massege, preferredStyle: .alert)
        // alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "OK".localized, style: .cancel, handler: nil))
        context.present(alert, animated: true)
    }
    
    static func backToLogin(_ title:String, massege:String , context:UIViewController) {
        let alert = UIAlertController(title: title, message: massege, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "LogIn".localized, style: .cancel, handler: { (action) in
            if let vc = context.storyboard?.instantiateViewController(withIdentifier: "LogIn") as? LogInViewController {
                context.present(vc, animated: true, completion: nil)
            }
        }))
        context.present(alert, animated: true)

    }
    
    static func showWithAction(_ title:String, massege:String , context:UIViewController , completion: @escaping (UIAlertAction)->Void ) {
        let alert = UIAlertController(title: title, message: massege, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".localized, style: .cancel, handler: { (action) in
            completion(action)
        }))
        context.present(alert, animated: true)
    }
}
