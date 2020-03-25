//
//  ConsultationFilesViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 1/28/20.
//  Copyright © 2020 begroup. All rights reserved.
//

import UIKit
import FirebaseStorage
import MobileCoreServices

class ConsultationFilesViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var filesTableView: UITableView!
    @IBOutlet weak var consultationStatus: UILabel!
    
    //MARK:- Variables
    
    let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String], in: .import)
    var consultation_id: Int?
    var files: ConsultationFiles?
    
    //MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFiels()
        filesTableView.dataSource = self
        filesTableView.delegate = self
        filesTableView.rowHeight = 70
        if let status = ConsultationDetailsViewController.status {
            consultationStatus.text = status
        }
    }
    
    //MARK:- IBActions
    
    @IBAction func UploadFile(_ sender: UIButton) {
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    func getFiels(){
        consultation_id = ConsultationDetailsViewController.consultation_id
        if let id = consultation_id {
            DispatchQueue.main.async { [weak self] in
                APIClient.consultationFiles(consultation_id: id) { (result, status) in
                    switch result {
                    case .success(let response):
                        print(response)
                        self?.files = response.consultation
                        self?.filesTableView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                        Alert.show("Error".localized, massege: "Please check your network connection and try again".localized, context: self!)
                    }
                }
            }
        }
    }
    
//    func downloadFileFromFirebase(from url: String) {
//        let url = Storage.storage().reference(forURL: url)
//        let dir = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first
//        let localDir = dir?.appendingPathComponent("Report")
//        url.write(toFile: localDir!) { (url, error) in
//            if error != nil {
//                Alert.show("Failed".localized, massege: "Please Try Again".localized, context: self)
//                print(error?.localizedDescription ?? "")
//            }else {
//                self.presentActivityViewController(withUrl: url!)
//            }
//        }
//    }
//    func downloadFileFromFirebase() {
//        let url = Storage.storage().reference(forURL: "")
//        let dir = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first
//        let localDir = dir?.appendingPathComponent("Report")
//        url.write(toFile: localDir!) { (url, error) in
//            if error != nil {
//                print(error?.localizedDescription ?? "")
//            }else {
//                self.presentActivityViewController(withUrl: url!)
//            }
//        }
//    }
    
//    func ss (){
//        let storageRef = Storage.storage().reference().child("Ali")
//               let url = storageRef.child(filesArray[indexPath.row])
//
//               let dir = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first
//               let localDir = dir?.appendingPathComponent("\(filesArray[indexPath.row]).txt")
//               url.write(toFile: localDir!) { (url, error) in
//                   if error != nil {
//                       print(error?.localizedDescription ?? "Error But No Description")
//                   }else {
//                       self.presentActivityViewController(withUrl: url!)
//                   }
//               }
//    }
    
}

//MARK:- TableView Set Up

extension ConsultationFilesViewController: UITableViewDelegate , UITableViewDataSource {
    
    //MARK:- TabelView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files?.files.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilesCell", for: indexPath) as! FilesTableViewCell
        if let file = files?.files[indexPath.row] {
            cell.fileName.text = file
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("!")
        if let fileURL = URL(string: files?.files[indexPath.row] ?? "") {
            print(fileURL)
            UIApplication.shared.open(fileURL)
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

//MARK:- DocumentPicker SetUp
extension ConsultationFilesViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        FirebaseUploader.uploadFileToFirebase(viewController: self, documentPicker: documentPicker, urls: urls , completion: nil)
    }
}
