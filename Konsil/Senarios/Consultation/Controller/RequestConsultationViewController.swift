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

class RequestConsultationViewController: UIViewController{
    
    //MAKR:- IBOutlet
    @IBOutlet weak var consultationImage: UIImageView!
    @IBOutlet weak var submitBut: UIButton!{
        didSet{
            self.submitBut.layer.cornerRadius = self.submitBut.frame.height/2
        }
    }
    @IBOutlet weak var titleTF: UITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.titleTF, borderColor: UIColor.gray.cgColor, radius: 10)
            self.titleTF.clipsToBounds = true
        }
    }
    @IBOutlet weak var detailsTV: UITextView!{
        didSet{
            self.detailsTV.layer.cornerRadius = 10
            self.detailsTV.layer.borderWidth = 1.5
            self.detailsTV.layer.borderColor = UIColor.gray.cgColor
            self.detailsTV.delegate = self
        }
    }
    @IBOutlet weak var textViewHieghtConstraint: NSLayoutConstraint!
    
    //MARK:- Variables
    var imagePicker = OpalImagePickerController()
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
        textViewHieghtConstraint.constant = self.view.frame.height/5
    }
    
    
    @IBAction func completeRequestPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "consultationDetails") as! ConsultationDetailsViewController
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func uploadImage(_ sender: UIButton) {
        imagePicker.imagePickerDelegate = self
        imagePickerSettings()
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func uploadFiles(_ sender: UIButton) {
    }
    
    func imagePickerSettings() {
        let configuratations = OpalImagePickerConfiguration()
        configuratations.maximumSelectionsAllowedMessage = NSLocalizedString("You Can Select Up To 5 Photos",comment: "")
        imagePicker.maximumSelectionsAllowed = 5
        imagePicker.allowedMediaTypes = Set([.image])
        imagePicker.selectionTintColor = UIColor.black.withAlphaComponent(0.7)
        imagePicker.selectionImageTintColor = UIColor.white.withAlphaComponent(0.7)
        imagePicker.configuration = configuratations
    }
    
}


//MARK:- ImagePicker SetUp
extension RequestConsultationViewController: OpalImagePickerControllerDelegate , UITextViewDelegate {
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        print(images.count)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        detailsTV.text = ""
    }
}
