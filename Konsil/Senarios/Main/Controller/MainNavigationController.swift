//
//  MainNavigationController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/16/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import SideMenu
class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        checkConnection(view: self.view)
    }
    
    //MARK:- Change Status Bar To Dark
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
