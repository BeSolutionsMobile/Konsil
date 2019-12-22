//
//  SideMenuViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/15/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    
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
            ProfileImage.layer.cornerRadius = ProfileImage.frame.width/2
            ProfileImage.layer.borderWidth = 4
            ProfileImage.layer.borderColor = #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1)
        }
    }
    @IBOutlet weak var imageBackView: UIView!{
        didSet{
            imageBackView.layer.cornerRadius = imageBackView.frame.width/2
        }
    }
    
    @IBOutlet weak var name: UILabel!
    
    var segue = ["PersonalInfo" , "MyConsultation" , "FAQView" , "MyComplaints" , "Policy" ,"Be A Doctor"]
    //MARK:- viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func sideMenuButtonPressed(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            guard let vc = storyboard?.instantiateViewController(identifier: segue[sender.tag]) else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            guard let vc = storyboard?.instantiateViewController(identifier: segue[sender.tag]) else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            guard let vc = storyboard?.instantiateViewController(identifier: segue[sender.tag]) else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
//            guard let vc = storyboard?.instantiateViewController(identifier: segue[sender.tag]) else { return }
//            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 4:
//            guard let vc = storyboard?.instantiateViewController(identifier: segue[sender.tag]) else { return }
//            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 5:
            guard let vc = storyboard?.instantiateViewController(identifier: segue[sender.tag]) else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(identifier: "LogIn") as? LogInViewController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}
