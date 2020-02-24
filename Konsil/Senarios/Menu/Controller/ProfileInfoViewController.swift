//
//  ProfileInfoViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/19/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import Photos

class ProfileInfoViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var name: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.name, borderColor: CGColor.kBlue, radius: self.name.frame.height/2)
        }
    }
    @IBOutlet weak var email: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.email, borderColor: CGColor.kBlue, radius: self.email.frame.height/2)
        }
    }
    @IBOutlet weak var password: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.password, borderColor: CGColor.kBlue, radius: self.password.frame.height/2)
        }
    }
    @IBOutlet weak var phone: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.phone, borderColor: CGColor.kBlue, radius: self.phone.frame.height/2)
        }
    }
    @IBOutlet weak var photo: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.photo, borderColor: CGColor.kBlue, radius: self.photo.frame.height/2)
        }
    }
    @IBOutlet weak var patientHistoryTV: UITextView!{
        didSet{
            Rounded.roundedCornerTextView(textView: patientHistoryTV, borderColor: CGColor.kBlue, radius: 10, borderWidth: 1.5)
            patientHistoryTV.delegate = self
            patientHistoryTV.text = "Enter Patient History Here".localized
        }
    }
    @IBOutlet weak var patientHistoryLabel: UILabel!{
        didSet{
            patientHistoryLabel.text = "Patient History".localized
        }
    }
    @IBOutlet weak var submit: UIButton!{
        didSet{
            self.submit.layer.cornerRadius = self.submit.frame.height/2
        }
    }
    @IBOutlet weak var redView: UIView!{
        didSet{
            self.redView.layer.cornerRadius = 60
        }
    }
    @IBOutlet weak var blueView: UIView!{
        didSet{
            self.blueView.layer.cornerRadius = 58
            self.blueView.layer.maskedCorners = [.layerMaxXMaxYCorner , .layerMinXMaxYCorner]
        }
    }
    
    //MARK:- Variables
    
    let imagePicker = UIImagePickerController()
    var image: String?
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
        updateView()
        
    }
    
    @IBAction func uploadProfileImage(_ sender: UIButton) {
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    func changePersonalInfo() {
        if let user = Shared.user , name.text!.count >= 3 , password.text!.count >= 8 , phone.text!.count >= 10 {
            print(2)
            if name.text != user.name || email.text != user.email || phone.text != user.phone || image != user.image_url || image == nil{
                print(3)
                APIClient.changePersonalInfo(name: name.text ?? "", email: email.text ?? "", password: password.text ?? "", phone: phone.text ?? "", image_url: image ?? user.image_url ?? "" ) { (Result, Status) in
                    switch Result {
                    case .success(let response):
                        if response.status == 200 {
                            print(response)
                            Shared.user = response.userInfo
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        Alert.show("Error".localized, massege: "Please Try Again".localized, context: self)
                    }
                }
            }
        } else {
            if let mail = email.text {
                let valied = email.isValidEmail(mail)
                if valied == false {
                    email.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
                }
            }
            if name.text!.count < 3  {
                name.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            }
            if phone.text!.count < 10 {
                phone.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            }
            if password.text!.count < 8 {
                password.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            }
        }
    }
    
    @IBAction func submitChanges(_ sender: UIButton) {
        changePersonalInfo()
    }
    
    //MARK:- Methodes
    func updateView(){
        if let user = Shared.user , Shared.user != nil {
            name.text = user.name
            email.text = user.email
            password.text = ""
            phone.text = user.phone
            image = user.image_url
        }
    }
    
    @IBAction func textDidChange(_ sender: UITextField) {
           if sender.layer.borderColor != UIColor.gray.cgColor {
               sender.layer.borderColor = UIColor.gray.cgColor
           }
       }
       
       func textFieldDidBeginEditing(_ textField: UITextField) {
           if textField.layer.borderColor != UIColor.gray.cgColor {
               textField.layer.borderColor = UIColor.gray.cgColor
           }
       }
}

//MARK:- Image Picker Delegates
extension ProfileInfoViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        FirebaseUploader.uploadToFirebase(viewController: self, imagePicker: imagePicker, didFinishPickingMediaWithInfo: info) { [weak self] (uploaded ,url) in
            if uploaded {
                self?.image = url
//                if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset{
//                    if let fileName = asset.value(forKey: "filename") as? String{
//                        self?.photo.text = fileName
//                    }
//                }
            }
        }
    }
    
}
