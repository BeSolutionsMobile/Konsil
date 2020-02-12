//
//  SideMenuViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/15/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import MOLH
class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var logOut: UIButton!{
        didSet{
            Rounded.roundButton(button: self.logOut, radius: self.logOut.frame.height/2)
        }
    }
    @IBOutlet weak var mainView: UIView!{
        didSet{
            Rounded.roundedCornerView(view: mainView, borderColor: CGColor.kBlue, radius: 30, borderWidth: 3)
            mainView.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMaxXMaxYCorner]
        }
    }
    @IBOutlet var sideMenuBut: [UIButton]!
    @IBOutlet weak var ProfileImage: UIImageView!{
        didSet{
            Rounded.roundedImage(imageView: ProfileImage, radius: ProfileImage.frame.width/2, borderColor: CGColor.kBlue, borderWidth: 3)
        }
    }
    @IBOutlet weak var imageBackView: UIView!{
        didSet{
            imageBackView.layer.cornerRadius = imageBackView.frame.width/2
        }
    }
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var name: UILabel!
    
    var segue = ["PersonalInfo" , "MyConsultation" , "FAQView" , "MyComplaints" , "Policy" ,"Become A Doctor"]
    
    //MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    //MARK:- IB Actions
    @IBAction func changeLanguage(_ sender: UIButton) {
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en" )
        DispatchQueue.main.async {
            APIClient.changeLanguage(lang:MOLHLanguage.currentAppleLanguage()) { (Result, Status) in
                switch Result {
                case .success(let response):
                    print(response)
                    MOLH.reset()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    @IBAction func sideMenuButtonPressed(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            guard let vc = storyboard?.instantiateViewController(withIdentifier: segue[sender.tag]) else { return }
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 1:
            guard let vc = storyboard?.instantiateViewController(withIdentifier: segue[sender.tag]) else { return }
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 2:
            guard let vc = storyboard?.instantiateViewController(withIdentifier: segue[sender.tag]) else { return }
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 3:
            //            guard let vc = storyboard?.instantiateViewController(withIdentifier: segue[sender.tag]) else { return }
            //            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 4:
            //            guard let vc = storyboard?.instantiateViewController(withIdentifier: segue[sender.tag]) else { return }
            //            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 5:
            guard let vc = storyboard?.instantiateViewController(withIdentifier: segue[sender.tag]) else { return }
            self.navigationController?.pushViewController(vc, animated: true)
            
        default:
            break
        }
    }
    
    func updateView(){
        if let user = Shared.user , Shared.user != nil {
            name.text = user.name
            ProfileImage.sd_setImage(with: URL(string: user.image_url ?? ""), placeholderImage: UIImage(named: "sd_setImage"), options: .delayPlaceholder)
            
        }
    }
    
    //MARK:- Log Out
    @IBAction func logOut(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "LogIn") as? LogInViewController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}
