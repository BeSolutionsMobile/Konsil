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
            self.tableView.layer.cornerRadius = 10
            self.tableView.clipsToBounds = true
            self.tableView.layer.borderColor = UIColor.darkGray.cgColor
            self.tableView.layer.borderWidth = 2
        }
    }
    
    @IBOutlet weak var imageBackGroundView: UIView!{
        didSet{
            self.imageBackGroundView.layer.cornerRadius = self.imageBackGroundView.frame.height/2
            self.imageBackGroundView.layer.borderWidth = 2
            self.imageBackGroundView.layer.borderColor = UIColor.gray.cgColor
            self.imageBackGroundView.clipsToBounds = true
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
            self.requestConsultarionBack.layer.maskedCorners = [ .layerMinXMaxYCorner, .layerMinXMinYCorner ]
            self.requestConsultarionBack.clipsToBounds = true
        }
    }
    @IBOutlet weak var requestConversationBack: UILabel!{
        didSet{
            self.requestConversationBack.layer.cornerRadius = 15
            self.requestConversationBack.layer.maskedCorners = [.layerMaxXMaxYCorner , .layerMaxXMinYCorner]
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
        let vc = storyboard?.instantiateViewController(identifier: "ConsultationRequest") as! RequestConsultationViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func requestOnlineConversationPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "DoctorConversation") as! DoctorConversationViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
