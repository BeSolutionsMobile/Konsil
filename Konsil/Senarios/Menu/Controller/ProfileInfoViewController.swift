//
//  ProfileInfoViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/19/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

class ProfileInfoViewController: UIViewController , UITextViewDelegate {
    
    @IBOutlet weak var name: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.name, borderColor: #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1), radius: self.name.frame.height/2)
        }
    }
    @IBOutlet weak var email: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.email, borderColor: #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1), radius: self.email.frame.height/2)
        }
    }
    @IBOutlet weak var password: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.password, borderColor: #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1), radius: self.password.frame.height/2)
        }
    }
    @IBOutlet weak var phone: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.phone, borderColor: #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1), radius: self.phone.frame.height/2)
        }
    }
    @IBOutlet weak var photo: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.photo, borderColor: #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1), radius: self.photo.frame.height/2)
        }
    }
    @IBOutlet weak var patientHistoryTV: UITextView!{
        didSet{
            patientHistoryTV.layer.cornerRadius = 10
            patientHistoryTV.layer.borderColor = #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1)
            patientHistoryTV.layer.borderWidth = 1.5
            patientHistoryTV.delegate = self
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rightBackBut()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.patientHistoryTV.text = ""
    }
}
