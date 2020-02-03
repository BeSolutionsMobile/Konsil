//
//  ConversationReportViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/18/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

class ConversationReportViewController: UIViewController {
    
    @IBOutlet weak var complaintBut: UIButton!{
        didSet{
            self.complaintBut.layer.cornerRadius = self.complaintBut.frame.height/2
        }
    }
    @IBOutlet weak var conversationStatus: UILabel!
    @IBOutlet weak var dateOfReport: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func downloadPressed(_ sender: UIButton) {
    }
    
    @IBAction func makeComplaintPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Make A Complaint") as! MakeComplaintViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
