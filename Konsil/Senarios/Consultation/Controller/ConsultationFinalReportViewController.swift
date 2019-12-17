//
//  ConsultationFinalReportViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/17/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

class ConsultationFinalReportViewController: UIViewController {

    @IBOutlet weak var dateOfReport: UILabel!
    @IBOutlet weak var consultationStatus: UILabel!
    @IBOutlet weak var requestChat: UIButton!{
        didSet{
            self.requestChat.layer.cornerRadius
                = self.requestChat.frame.height/2
        }
    }
    @IBOutlet weak var makeComplaint: UIButton!{
        didSet{
            self.makeComplaint.layer.cornerRadius = self.makeComplaint.frame.height/2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func downloadFilesPressed(_ sender: UIButton) {
    }
    
    @IBAction func requestOnlineChatPressed(_ sender: UIButton) {
        
    }
    @IBAction func makeComplaintPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "Make A Complaint") as! MakeComplaintViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

class MyBarButtonItem:UINavigationItem {
    
    
    func s(){
        
        
        self.hidesBackButton = true
        self.rightBarButtonItem = UIBarButtonItem(title: ">", style: .done, target: nil, action: #selector(rightBackBut))
    }
    
    @objc func rightBackBut(){
        
    }
}
