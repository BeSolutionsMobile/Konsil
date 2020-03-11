//
//  RequestConsultationViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/17/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import SideMenu
import OpalImagePicker
import MobileCoreServices

class RequestConsultationViewController: UIViewController {
    
    //MAKR:- IBOutlet
    @IBOutlet weak var imageCheckView: UIView!
    @IBOutlet weak var fileCheckView: UIView!
    @IBOutlet weak var submitBut: UIButton!{
        didSet{
            self.submitBut.layer.cornerRadius = self.submitBut.frame.height/2
        }
    }
    @IBOutlet weak var titleTF: UITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.titleTF, borderColor: UIColor.gray.cgColor, radius: 10)
        }
    }
    @IBOutlet weak var detailsTV: UITextView!{
        didSet{
            Rounded.roundedCornerTextView(textView: detailsTV, borderColor: UIColor.gray.cgColor, radius: 10, borderWidth: 1.5)
            detailsTV.delegate = self
            detailsTV.text = "Enter Consultation Details Here".localized
        }
    }
    @IBOutlet weak var textViewHieghtConstraint: NSLayoutConstraint!
    
    //MARK:- Variables
    var imagePicker = OpalImagePickerController()
    let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String], in: .import)
    var files: [String]?
    var images: [String]?
    var imageUploaded = false
    var filesUploaded = false
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
        //        textViewHieghtConstraint.constant = self.view.frame.height/5
    }
    
    //MARK:- IBActions
    @IBAction func completeRequestPressed(_ sender: UIButton) {
        addConsultation()
    }
    
    @IBAction func uploadImage(_ sender: UIButton) {
        imagePicker.imagePickerDelegate = self
        imagePickerSettings()
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func uploadFiles(_ sender: UIButton) {
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true, completion: nil)
    }
    //MARK:- Methodes
    
    func addConsultation() {
        if let title = titleTF.text, let details = detailsTV.text, titleTF.text != "" {
            print("Requesting")
            
            DispatchQueue.main.async { [weak self] in
                APIClient.addConsultation(title: title, details: details, doctor_id: 26, images: self?.images ?? ["noImages"], files: self?.files ?? ["noFiles"]) { (Result , Status) in
                    switch Result {
                    case .success(let response):
                        print(response)
                        if response.status == 200 {
                            if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "PayPalVC") as? PayPalViewController {
                                vc.modalPresentationStyle = .fullScreen
                                vc.doctor = "Consultation"
                                vc.price = "2.5"
                                vc.id = response.id
                                vc.type = 1
                                self?.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                   print(Status)
                }
            }
        } else {
            print("no")
            if titleTF.text == "" || detailsTV.text == "" {
                print("1")
                Alert.show("Error".localized, massege: "All Fields Are Required".localized, context: self)
            } else if imageUploaded == false && filesUploaded == false {
                print("2")
                Alert.show("Error".localized, massege: "Please upload images and files of the medical consultaion".localized, context: self)
            }
        }
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
}

//MARK:- ImagePicker / DocumnetPicker SetUp
extension RequestConsultationViewController: OpalImagePickerControllerDelegate , UIDocumentPickerDelegate{
    
    //MARK:- Image Picker
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        for i in images.indices {
            FirebaseUploader.uploadImagesToFirebase(viewController: self, imagePicker: imagePicker, pickedImage: images[i]) {[weak self] (uploaded, imagesURL) in
                if uploaded == true {
                    self?.imageUploaded = true
                    self?.images = imagesURL
                    let animation = Shared.showLottie(view: self!.imageCheckView, fileName: "CheckMark", contentMode: .scaleAspectFit)
                    animation.play()
                }
            }
        }
    }
    
    //MARK:- Document Picker
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        FirebaseUploader.uploadFileToFirebase(viewController: self, documentPicker: documentPicker, urls: urls) { [weak self] (Finished, filesURL) in
            if Finished {
                self?.filesUploaded = true
                self?.files = filesURL
                let animation = Shared.showLottie(view: self!.fileCheckView, fileName: "CheckMark", contentMode: .scaleAspectFit)
                animation.play()
            }
        }
    }
}
