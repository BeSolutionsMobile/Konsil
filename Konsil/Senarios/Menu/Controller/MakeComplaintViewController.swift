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
            complaintMessageTV.layer.cornerRadius = 7
            complaintMessageTV.layer.borderColor = #colorLiteral(red: 0.1999711692, green: 0.2000181675, blue: 0.1999708116, alpha: 1)
            complaintMessageTV.layer.borderWidth = 1.5
        }
    }
    @IBOutlet weak var complaintMessageTV: UITextView!{
        didSet{
            complaintMessageTV.layer.cornerRadius = 7
            complaintMessageTV.layer.borderColor = #colorLiteral(red: 0.1999711692, green: 0.2000181675, blue: 0.1999708116, alpha: 1)
                complaintMessageTV.layer.borderWidth = 1.5
        }
    }
    @IBOutlet weak var submitBut: UIButton!{
        didSet{
            submitBut.layer.cornerRadius = submitBut.frame.height/2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "ComplaintDetails") as! ComplaintDetailsViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
