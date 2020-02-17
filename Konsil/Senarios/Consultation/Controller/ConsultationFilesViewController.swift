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
    @IBOutlet weak var requestConversation: UIButton!{
        didSet{
            Rounded.roundButton(button: requestConversation, radius: requestConversation.bounds.height/2)
        }
    }
    @IBOutlet weak var ConsultationStatus: UILabel!
    
    //MARK:- Variables
    
    let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String], in: .import)
    let filesArray = ["o3KNDjONzCg1u1w8vdGH" ,"o3KNDjONzCg1u1w8vdGH" ,"o3KNDjONzCg1u1w8vdGH" ,"o3KNDjONzCg1u1w8vdGH"]
    
    
    //MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filesTableView.dataSource = self
        filesTableView.delegate = self
        filesTableView.rowHeight = 70
    }
    
    //MARK:- IBActions
    
    @IBAction func UploadFile(_ sender: UIButton) {
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true, completion: nil)
    }
    
//    func getData(){
//        DispatchQueue.main.async { [weak self] in
//            
//        }
//    }
    

}

//MARK:- TableView Set Up

extension ConsultationFilesViewController: UITableViewDelegate , UITableViewDataSource {
    
    //MARK:- TabelView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilesCell", for: indexPath) as! FilesTableViewCell
        cell.fileName.text = filesArray[indexPath.row]
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storageRef = Storage.storage().reference().child("Ali")
        let url = storageRef.child(filesArray[indexPath.row])
            
        let dir = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first
        let localDir = dir?.appendingPathComponent("\(filesArray[indexPath.row]).txt")
        url.write(toFile: localDir!) { (url, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Error But No Description")
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

//MARK:- DocumentPicker SetUp
extension ConsultationFilesViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        FirebaseUploader.uploadFileToFirebase(viewController: self, documentPicker: documentPicker, urls: urls , completion: nil)
    }
}
