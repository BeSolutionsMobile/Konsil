//
//  RequestConsultationViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/17/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import SideMenu
class RequestConsultationViewController: UIViewController {
    
    @IBOutlet weak var consultationImage: UIImageView!
    @IBOutlet weak var submitBut: UIButton!{
        didSet{
            self.submitBut.layer.cornerRadius = self.submitBut.frame.height/2
        }
    }
    @IBOutlet weak var titleTF: UITextField!{
        didSet{
            self.titleTF.layer.cornerRadius = 10
            self.titleTF.layer.borderColor = #colorLiteral(red: 0.1999711692, green: 0.2000181675, blue: 0.1999708116, alpha: 1)
            self.titleTF.layer.borderWidth = 2
            self.titleTF.clipsToBounds = true
        }
    }
    @IBOutlet weak var detailsTV: UITextView!{
        didSet{
            self.detailsTV.layer.cornerRadius = 10
            self.detailsTV.layer.borderWidth = 2
            self.detailsTV.layer.borderColor = #colorLiteral(red: 0.1999711692, green: 0.2000181675, blue: 0.1999708116, alpha: 1)
        }
    }
    @IBOutlet weak var textViewHieghtConstraint: NSLayoutConstraint!
    
    var imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        textViewHieghtConstraint.constant = self.view.frame.height/5
    }
    
    @IBAction func completeRequestPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "consultationDetails") as! ConsultationDetailsViewController
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func uploadImage(_ sender: UIButton) {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func uploadFiles(_ sender: UIButton) {
    }
    
    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(identifier: "SideMenu") as! SideMenuNavigationController
        vc.modalPresentationStyle = .overFullScreen
        vc.settings = Shared.settings(view: self.view)
        self.present(vc, animated: true, completion: nil)
    }
}



//MARK:- ImagePicker SetUp
extension RequestConsultationViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
