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

    @IBOutlet weak var doctorImage: UIImageView!{
        didSet{
            self.doctorImage.layer.cornerRadius = self.doctorImage.frame.width/2
            self.doctorImage.layer.borderColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            self.doctorImage.layer.borderWidth = 3
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func requestConsultationPressed(_ sender: UIButton) {
    }
    @IBAction func requestOnlineConversationPressed(_ sender: UIButton) {
    }
    
    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(identifier: "SideMenu") as! SideMenuNavigationController
        vc.modalPresentationStyle = .overFullScreen
        vc.settings = Shared.settings(view: self.view)
        self.present(vc, animated: true, completion: nil)
    }
}
