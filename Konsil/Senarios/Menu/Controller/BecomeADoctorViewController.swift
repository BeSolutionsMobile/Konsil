//
//  BecomeADoctorViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/15/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import SideMenu
class BecomeADoctorViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    @IBOutlet weak var imageBackView: UIView!{
        didSet{
            Rounded.roundedCornerView(view: imageBackView, borderColor: UIColor.gray.cgColor, radius: imageBackView.frame.width/2, borderWidth: 3)
        }
    }
    @IBOutlet weak var addImage: UIImageView!{
        didSet{
            Rounded.roundedImage(imageView: addImage, radius: addImage.frame.width/2, borderColor: #colorLiteral(red: 0.8985823989, green: 0.9336386919, blue: 0.9438558221, alpha: 1), borderWidth: 4)
        }
    }
    @IBOutlet weak var addName: UITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.addName, borderColor: CGColor.kBlue , radius: self.addName.frame.height/2)
        }
    }
    @IBOutlet weak var addEmail: UITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.addEmail, borderColor: CGColor.kBlue , radius: self.addEmail.frame.height/2)
        }
    }
    @IBOutlet weak var addPassword: UITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.addPassword, borderColor: CGColor.kBlue , radius: self.addPassword.frame.height/2)
        }
    }
    @IBOutlet weak var addPhone: UITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.addPhone, borderColor: CGColor.kBlue , radius: self.addPhone.frame.height/2)
        }
    }
    @IBOutlet weak var submitBut: UIButton!{
        didSet{
            submitBut.layer.cornerRadius = submitBut.frame.height / 2
        }
    }
    
    let imagePicker = UIImagePickerController()
    //MARK:- ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func requestButPressed(_ sender: UIButton) {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            addImage.image = image
        }
        _ = FirebaseUploader.uploadToFirebase(viewController: self, imagePicker: imagePicker, didFinishPickingMediaWithInfo: info , completion: nil)
    }
    
}
