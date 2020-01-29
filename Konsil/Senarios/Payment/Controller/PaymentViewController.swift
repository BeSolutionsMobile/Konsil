//
//  PaymentViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 1/29/20.
//  Copyright © 2020 begroup. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    //MARK:- IBOutlets
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var bankDetailsView: UIView!{
        didSet{
            bankDetailsView.layer.cornerRadius = 10
            bankDetailsView.layer.borderColor = UIColor.darkGray.cgColor
            bankDetailsView.layer.borderWidth = 1.5
            bankDetailsView.clipsToBounds = true
        }
    }
    @IBOutlet weak var accountNumber: UILabel!
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var bankName: UILabel!
    @IBOutlet weak var bankTransfer: UITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: bankTransfer, borderColor: UIColor.darkGray.cgColor, radius: 10 , borderWidth: 1.5)
        }
    }
    @IBOutlet weak var visa: UITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: visa, borderColor: UIColor.darkGray.cgColor, radius: 10 , borderWidth: 1.5)
        }
    }
    @IBOutlet weak var masterCard: UITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: masterCard, borderColor: UIColor.darkGray.cgColor, radius: 10 , borderWidth: 1.5)
        }
    }
    @IBOutlet weak var completeBut: UIButton!{
        didSet{
            Rounded.roundButton(button: completeBut, radius: completeBut.bounds.height/2)
        }
    }
    
    //MARK:- Variables
    
    let imagePicker = UIImagePickerController()
    
    
    //MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- IBActions
    
    @IBAction func uploadReceipt(_ sender: UIButton) {
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func completeRequest(_ sender: UIButton) {
        if #available(iOS 13.0, *) {
            if let vc = storyboard?.instantiateViewController(identifier: "Main") as? MainViewController {
                vc.modalPresentationStyle = .fullScreen
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    //MARK:- ImagePicker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        _ = FirebaseUploader.uploadToFirebase(viewController: self, imagePicker: imagePicker, didFinishPickingMediaWithInfo: info)
    }
    
}
