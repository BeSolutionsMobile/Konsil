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
            mainView.layer.cornerRadius = 30
            mainView.layer.borderWidth = 3
            mainView.layer.borderColor = #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1)
            mainView.clipsToBounds = true
            mainView.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMaxXMaxYCorner]
        }
    }
    @IBOutlet var sideMenuBut: [UIButton]!
    @IBOutlet weak var ProfileImage: UIImageView!{
        didSet{
            Rounded.roundedImage(imageView: ProfileImage, radius: ProfileImage.frame.width/2, borderColor: #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1), borderWidth: 3)
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
        
    }
    
    //MARK:- IB Actions
    @IBAction func changeLanguage(_ sender: UIButton) {
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "de" : "en" )
        MOLH.reset()
        //        if #available(iOS 13.0, *) {
        //            let delegate = UIApplication.shared.delegate as? AppDelegate
        ////            delegate!.swichRoot()
        //        } else {
        //            MOLH.reset()
        //        }
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
    
    //MARK:- Log Out
    @IBAction func logOut(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "LogIn") as? LogInViewController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}
