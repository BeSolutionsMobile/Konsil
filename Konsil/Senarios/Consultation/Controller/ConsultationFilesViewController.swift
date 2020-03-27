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
import SafariServices

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
            self.startAnimating()
            DispatchQueue.main.async { [weak self] in
                APIClient.consultationFiles(consultation_id: id) { (result, status) in
                    self?.stopAnimating()
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
//        let url = files?.files[indexPath.row].addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let fileURL = URL(string: files?.files[indexPath.row] ?? "") {
//            let safariVC = SFSafariViewController(url: fileURL)
//            self.present(safariVC, animated: true, completion: nil)
            UIApplication.shared.open(fileURL as URL, options: [:], completionHandler: nil)
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
