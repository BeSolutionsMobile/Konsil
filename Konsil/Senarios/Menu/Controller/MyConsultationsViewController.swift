//
//  MyConsultationsViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/19/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

class MyConsultationsViewController: UIViewController {
    
    @IBOutlet weak var myConsultationTableView: UITableView!{
        didSet {
            self.myConsultationTableView.rowHeight = UITableView.automaticDimension
            self.myConsultationTableView.estimatedRowHeight = 110
        }
    }
    var name = ["Nour" , "Wael Mansour" , "Mahmoud Samir" , "Nermeen Fouad" , "Ramy El Badry" , "Naser Ali" , "Ali Essa" , "Adham Samir"]
    var deg = ["Professor" , "Specialist"  , "Professor" , "Advisory" , "Specialist" , "Advisory" , "Professor" , "Advisory"]
    var images = ["3" , "4"  , "5" , "6" , "7" , "8" , "9" , "10"]
    var prie = ["350" , "400"  , "540" , "300" , "270" , "340" , "400" , "450"]
    var tybes = ["Online Conversation".localized , "Consultation".localized   , "Consultation".localized  , "Consultation".localized  , "Online Conversation".localized  , "Online Conversation".localized  , "Online Conversation".localized  , "Consultation".localized ]
    
    //MARK:- ViewDidLoad
    var consultations: [MyConsultation]?
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
        getMyconsultations()
    }
    
    
    func getMyconsultations(){
        DispatchQueue.main.async { [weak self] in
            APIClient.getMyConsultations { (Result, Status) in
                switch Result {
                case .success(let response):
                    print(response)
                    if Status == 200 {
                        self?.consultations = response.data
                        self?.myConsultationTableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

//MARK:- tableView Setup
extension MyConsultationsViewController: UITableViewDelegate , UITableViewDataSource , ConsultationDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return consultations?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyConsultationsCell", for: indexPath) as! MyConsultationsTableViewCell
        if let consultation = consultations?[indexPath.row] {
            cell.doctorName.text = consultation.name
            cell.price.text = consultation.price
            cell.doctorImage.sd_setImage(with: URL(string: consultation.image), placeholderImage: UIImage(named: "imagePlaceholder"))
            switch consultation.type {
            case "1": cell.tybe.text = "Consultation".localized
            case "2": cell.tybe.text = "OnlineConversation".localized
            default:
                break
            }
            cell.tybe.text = consultation.type
            cell.delegate = self
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tybes[indexPath.row] == "Consultation".localized {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "consultationDetails") as? ConsultationDetailsViewController {
                vc.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ConversationDetails") as? ConversationDetailsViewController {
                vc.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func viewDidPressed() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "consultationDetails") as? ConsultationDetailsViewController {
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
