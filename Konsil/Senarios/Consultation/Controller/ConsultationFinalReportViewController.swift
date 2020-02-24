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
    
    var reportFile: Report?
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
        getData()
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
    
    func downloadFileFromFirebase() {
        if let report = reportFile {
            let url = Storage.storage().reference(forURL: report.url)
            let dir = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first
            let localDir = dir?.appendingPathComponent("Report")
            url.write(toFile: localDir!) { (url, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                }else {
                    self.presentActivityViewController(withUrl: url!)
                }
            }
        } else {
            if reportFile == nil {
                Alert.show("Error".localized, massege: "no file was found", context: self)
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
    
    func getData(){
        DispatchQueue.main.async { [weak self] in
            APIClient.downloadReport(consultation_id: 66) { (Result , Status) in
                switch Result {
                case .success(let response):
                    self?.reportFile = response.report
                    print(response)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
