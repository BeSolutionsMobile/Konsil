//
//  ProfileInfoViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/19/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

class ProfileInfoViewController: UIViewController {
    
    @IBOutlet weak var name: DesignableUITextField!{
        didSet{ Rounded.profileRoundedCornerTextField(textField: self.name)}}
    @IBOutlet weak var email: DesignableUITextField!{
        didSet{ Rounded.profileRoundedCornerTextField(textField: self.email)}}
    @IBOutlet weak var password: DesignableUITextField!{
        didSet{ Rounded.profileRoundedCornerTextField(textField: self.password)}}
    @IBOutlet weak var phone: DesignableUITextField!{
        didSet{ Rounded.profileRoundedCornerTextField(textField: self.phone)}}
    @IBOutlet weak var photo: DesignableUITextField!{
        didSet{ Rounded.profileRoundedCornerTextField(textField: self.photo)}}
    @IBOutlet weak var submit: UIButton!{
        didSet{
            self.submit.layer.cornerRadius = self.submit.frame.height/2}}
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
    
    
}
