//
//  ConsultationFinalReportViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/17/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import FirebaseStorage
class ConsultationFinalReportViewController: UIViewController {
    
    //MARK:- IBOutlets
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
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
    }
    
    //MARK:- IBOutlets
    @IBAction func downloadFilesPressed(_ sender: UIButton) {
        downloadFileFromFirebase()
    }
    
    @IBAction func requestOnlineChatPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DoctorConversation") as? DoctorConversationViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func makeComplaintPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Make A Complaint") as? MakeComplaintViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //MARK:- Variables
    func downloadFileFromFirebase(){
        let storageRef = Storage.storage().reference().child("Ali")
        let url = storageRef.child("o3KNDjONzCg1u1w8vdGH")
        
        let dir = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first
        let localDir = dir?.appendingPathComponent("Item.txt")
        url.write(toFile: localDir!) { (url, error) in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                self.presentActivityViewController(withUrl: url!)
            }
        }
        
        
    }
    
    func presentActivityViewController(withUrl url: URL) {
        DispatchQueue.main.async {
            let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
}
