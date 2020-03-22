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
    @IBOutlet weak var indicator: UIActivityIndicatorView!
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
    @IBOutlet weak var patients: UILabel!
    @IBOutlet weak var consultationPrice: UILabel!
    @IBOutlet weak var conversation: UILabel!
    
    var doctorID: Int?
    var doctorDetails: DoctorData?
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
    }
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDoctorData()
    }
    
    //Get Data From 
    func getDoctorData(){
        if let id = doctorID {
            DispatchQueue.main.async { [weak self] in
                APIClient.doctorDetails(doctor_id: id) { (Result, Status) in
                    switch Result {
                    case .success(let response):
                        self?.updateView(doctor: response.doctor)
                        self?.doctorDetails = response.doctor
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    print(Status)
                }
            }
        }
    }
    
    func updateView(doctor: DoctorData){
//        doctorImage.sd_setImage(with: URL(string: doctor.image_url ), placeholderImage: UIImage(named: "doctorPlaceholder"))
        doctorImage.sd_setImage(with: URL(string: doctor.image_url), placeholderImage: nil, options: .retryFailed) { (image, error, type, url) in
            self.indicator.stopAnimating()
            
        }
        doctorName.text = doctor.name
        let rate = stringToDouble(doctor.rate)
        doctorRate.rating = rate
        doctorSpeciality.text = doctor.job_title
        details.text = doctor.bio
        consultationPrice.text = doctor.consultation_price
        conversation.text = String(doctor.total_conversation)
        patients.text = String(doctor.total_consultation)
    }
    
    @IBAction func requestConsultationPressed(_ sender: UIButton) {
        if doctorDetails != nil {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ConsultationRequest") as? RequestConsultationViewController {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            Alert.show("".localized, massege: "Failed", context: self)
        }
    }
    @IBAction func requestOnlineConversationPressed(_ sender: UIButton) {
        if doctorDetails != nil {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "DoctorConversation") as? DoctorConversationViewController {
                vc.doctorDetails = doctorDetails
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            Alert.show("".localized, massege: "Failed", context: self)
        }
    }
}
