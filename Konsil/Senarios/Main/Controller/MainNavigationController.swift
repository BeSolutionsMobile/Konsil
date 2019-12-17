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
    }

}

extension UIViewController {
    func rightBackBut() {
        navigationItem.hidesBackButton = true
        let rightBack = UIBarButtonItem(title: "", style: .done,target: self, action: #selector(addTapped))
        rightBack.image = UIImage(named: "rightArrow")
        navigationItem.rightBarButtonItem = rightBack
        let menuBut = UIBarButtonItem(title: "", style: .done,target: self, action: #selector(showMenu))
        menuBut.image = UIImage(named: "menuButton")
        navigationItem.leftBarButtonItem = menuBut
    }
    
    @objc func addTapped(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func showMenu(){
        let vc = storyboard?.instantiateViewController(identifier: "SideMenu") as! SideMenuNavigationController
        vc.modalPresentationStyle = .overFullScreen
        vc.settings = Shared.settings(view: self.view)
        self.present(vc, animated: true, completion: nil)
    }
}
