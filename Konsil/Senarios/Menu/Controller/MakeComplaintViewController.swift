//
//  MakeComplaintViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/15/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import SideMenu

class MakeComplaintViewController: UIViewController {
    
    @IBOutlet weak var selectTybeTF: UITextField!
    @IBOutlet weak var complaintMessageTV: UITextView!{
        didSet{
            complaintMessageTV.layer.cornerRadius = 10
            complaintMessageTV.layer.borderColor = UIColor.darkGray.cgColor
            complaintMessageTV.layer.borderWidth = 2
        }
    }
    @IBOutlet weak var submitBut: UIButton!{
        didSet{
            submitBut.layer.cornerRadius = submitBut.frame.height/2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        
        
    }
    
    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(identifier: "SideMenu") as! SideMenuNavigationController
        vc.modalPresentationStyle = .overFullScreen
        vc.settings = Shared.settings(view: self.view)
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
