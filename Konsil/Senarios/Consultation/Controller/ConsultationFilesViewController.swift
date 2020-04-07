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
import OpalImagePicker

class ConsultationFilesViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var filesTableView: UITableView!
    @IBOutlet weak var consultationStatus: UILabel!
    
    //MARK:- Variables
    
    let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String], in: .import)
    let imagePicker = OpalImagePickerController()
    var consultation_id: Int?
    var consultationFiles: ConsultationFiles?
    var status: String?
    
    //MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filesTableView.dataSource = self
        filesTableView.delegate = self
        filesTableView.rowHeight = 70
        status = ConsultationDetailsViewController.status
        consultation_id = ConsultationDetailsViewController.consultation_id
        if status != nil {
            consultationStatus.text = status
        }
        getFiels()
    }
    
    //MARK:- IBActions
    
    @IBAction func UploadFile(_ sender: UIButton) {
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    @IBAction func uploadImages(_ sender: UIButton) {
        imagePicker.imagePickerDelegate = self
        imagePickerSettings()
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerSettings() {
        let configuratations = OpalImagePickerConfiguration()
        configuratations.maximumSelectionsAllowedMessage = "You Can Select Up To 5 Photos".localized
        imagePicker.maximumSelectionsAllowed = 5
        imagePicker.allowedMediaTypes = Set([.image])
        imagePicker.selectionTintColor = UIColor.black.withAlphaComponent(0.7)
        imagePicker.selectionImageTintColor = UIColor.white.withAlphaComponent(0.7)
        imagePicker.configuration = configuratations
    }
    
    func getFiels(){
        if let id = consultation_id {
            self.startAnimating()
            DispatchQueue.main.async { [weak self] in
                APIClient.consultationFiles(consultation_id: id) { (result, status) in
                    self?.stopAnimating()
                    switch result {
                    case .success(let response):
                        print(response)
                        self?.consultationFiles = response.consultation
                        self?.filesTableView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                        Alert.show("Error".localized, massege: "Please check your network connection and try again".localized, context: self!)
                    }
                }
            }
        }
    }
    
    func uploadConsultationFiles(files: [String] ,images: [String]){
        if status != "closed".localized ,let id = consultation_id{
            self.startAnimating()
            DispatchQueue.global().async { [weak self] in
                APIClient.uploadConsultationFiles(consultationID: id, images: images, files: files) { (result, status) in
                    self?.stopAnimating()
                    switch result {
                    case .success(let response):
                        print(response)
                    case .failure(let error):
                        print(error.localizedDescription)
                        switch status {
                        case 402:
                            Alert.show("Failed", massege: "Consultation can not be found", context: self! )
                        case 403:
                            Alert.show("Failed", massege: "Consultation is closed by the doctor", context: self! )
                        case 404:
                            Alert.show("Failed", massege: "Consultation Not Found", context: self! )
                        case 200:
                            self?.getFiels()
                        default:
                            break
                        }
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
        return consultationFiles?.files.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilesCell", for: indexPath) as! FilesTableViewCell
        if let file = consultationFiles?.files[indexPath.row] {
            cell.fileName.text = file
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //        let url = files?.files[indexPath.row].addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let fileURL = URL(string: consultationFiles?.files[indexPath.row] ?? "") {
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
        FirebaseUploader.uploadFileToFirebase(viewController: self, documentPicker: documentPicker, urls: urls) {[weak self] (finished, files) in
            self?.uploadConsultationFiles(files: files, images: ["noImages"])
        }
    }
}

extension ConsultationFilesViewController: OpalImagePickerControllerDelegate {
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        for i in images.indices {
            if i == images.count - 1 {
                FirebaseUploader.uploadImagesToFirebase(viewController: self, imagePicker: imagePicker, pickedImage: images[i]) { (uploaded, imagesURL) in
                    if uploaded {
                        if imagesURL != [] {
                            self.uploadConsultationFiles(files: ["noFiles"], images: imagesURL)
                        }
                    }
                }
            } else {
                FirebaseUploader.uploadImagesToFirebase(viewController: self, imagePicker: imagePicker, pickedImage: images[i], completion: nil)
            }
            
        }
    }
}
