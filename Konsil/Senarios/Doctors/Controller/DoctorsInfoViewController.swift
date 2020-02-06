//
//  DoctorsInfoViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/16/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import Cosmos
import SideMenu

class DoctorsInfoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UIView!{
        didSet{
            Rounded.roundedCornerView(view: tableView, borderColor: UIColor.gray.cgColor, radius: 10, borderWidth: 2)
        }
    }
    
    @IBOutlet weak var imageBackGroundView: UIView!{
        didSet{
            Rounded.roundedCornerView(view: imageBackGroundView, borderColor: UIColor.gray.cgColor, radius: imageBackGroundView.frame.height/2, borderWidth: 2)
        }
    }
    @IBOutlet weak var doctorImage: UIImageView!{
        didSet{
            self.doctorImage.layer.cornerRadius = self.doctorImage.frame.width/2
        }
    }
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var doctorSpeciality: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var requestConsultarionBack: UILabel!{
        didSet{
            self.requestConsultarionBack.layer.cornerRadius = 15
            if "Lang".localized == "ar" {
                self.requestConsultarionBack.layer.maskedCorners = [.layerMaxXMaxYCorner , .layerMaxXMinYCorner]
            } else {
                self.requestConsultarionBack.layer.maskedCorners = [ .layerMinXMaxYCorner, .layerMinXMinYCorner ]
            }
            self.requestConsultarionBack.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var requestConversationBack: UILabel!{
        didSet{
            self.requestConversationBack.layer.cornerRadius = 15
            if "Lang".localized == "ar"{
                self.requestConversationBack.layer.maskedCorners = [ .layerMinXMaxYCorner, .layerMinXMinYCorner ]
            } else {
                self.requestConversationBack.layer.maskedCorners = [.layerMaxXMaxYCorner , .layerMaxXMinYCorner]
            }
            self.requestConversationBack.clipsToBounds = true
        }
    }
    @IBOutlet weak var doctorRate: CosmosView!
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
    }
    
    @IBAction func requestConsultationPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ConsultationRequest") as? RequestConsultationViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func requestOnlineConversationPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DoctorConversation") as? DoctorConversationViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
