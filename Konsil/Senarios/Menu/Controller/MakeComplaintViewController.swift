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
    
    @IBOutlet weak var selectTybeTF: UITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.selectTybeTF, color: UIColor.gray.cgColor , radius: 7)
            self.selectTybeTF.layer.borderWidth = 1.5
            self.selectTybeTF.clipsToBounds = true
        }
    }
    @IBOutlet weak var complaintMessageTV: UITextView!{
        didSet{
            complaintMessageTV.layer.cornerRadius = 7
            complaintMessageTV.layer.borderColor = UIColor.gray.cgColor
            complaintMessageTV.layer.borderWidth = 1.5
        }
    }
    @IBOutlet weak var submitBut: UIButton!{
        didSet{
            submitBut.layer.cornerRadius = submitBut.frame.height/2
        }
    }
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "ComplaintDetails") as! ComplaintDetailsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
