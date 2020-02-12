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
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var animationView: UIView!{
        didSet{
            self.animationView.layer.cornerRadius = 10
            self.animationView.clipsToBounds = true
        }
    }
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var bankDetailsView: UIView!{
        didSet{
            Rounded.roundedCornerView(view: bankDetailsView, borderColor: UIColor.darkGray.cgColor, radius: 10, borderWidth: 1.5)
        }
    }
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
    @IBOutlet weak var accountNumber: UILabel!
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var bankName: UILabel!
    
    //MARK:- Variables
    
    let imagePicker = UIImagePickerController()
    var imageURL = ""
    //MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
    }
    
    //MARK:- IBActions
    
    @IBAction func uploadReceipt(_ sender: UIButton) {
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func completeRequest(_ sender: UIButton) {
        backView.isUserInteractionEnabled = true
        backView.isHidden = false
        BlurView(view: animationView)
    }
    
    func BlurView(view: UIView){
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = view.bounds
        view.addSubview(blurView)
        view.isHidden = false
        let animation = Shared.showLottie(view: blurView.contentView, fileName: Animations.success , contentMode: .scaleAspectFit)
        blurView.contentView.addSubview(animation)
        view.addSubview(blurView)
        animation.play { (finished) in
            if finished == true {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "Main") as? MainViewController {
                    vc.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    //MARK:- ImagePicker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        FirebaseUploader.uploadToFirebase(viewController: self, imagePicker: imagePicker, didFinishPickingMediaWithInfo: info) {[weak self] (uploaded , url) in
            if uploaded == true {
                Alert.show("", massege: "Image Uploaded Successfully".localized, context: self!)
                self?.imageURL = url
            } else {
                Alert.show("", massege: "Failed To Upload Image", context: self!)
            }
        }
    }
    
}
