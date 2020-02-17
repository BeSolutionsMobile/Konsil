//
//  DoctorConversationViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/18/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import Cosmos
import BEMCheckBox

class DoctorConversationViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var doctorSpeciality: UILabel!
    @IBOutlet weak var doctorRate: CosmosView!
    @IBOutlet weak var hourPrice: UILabel!
    @IBOutlet weak var periodesTableView: UITableView!
    @IBOutlet weak var submitBut: UIButton!{
        didSet{
            self.submitBut.layer.cornerRadius = self.submitBut.frame.height/2
        }
    }
    @IBOutlet weak var doctorImage: UIImageView!{
        didSet{
            self.doctorImage.layer.cornerRadius = self.doctorImage.frame.width/2
        }
    }
    @IBOutlet weak var imageBackView: UIView!{
        didSet{
            Rounded.roundedCornerView(view: imageBackView, borderColor: UIColor.gray.cgColor, radius: self.imageBackView.frame.height/2, borderWidth: 2)
        }
    }
    @IBOutlet weak var backView: UIView!
    
    var currentIndex:IndexPath?
    var previousIndex:IndexPath?
    var new = 0
    var periods: [String]?
    var doctorDetails: DoctorData?
    var appointments: [Appointments]?
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
        getAppointments()
        updateView()
    }
    
    
    //MARK:- Complete Request
    @IBAction func completeRequestPressed(_ sender: UIButton) {
        reserveConversation()
    }
    
    // Reserve Conversation Appointment
    func reserveConversation() {
        if appointments?.count != nil , currentIndex != nil , doctorDetails?.id != nil{
            if let appointment = appointments?[currentIndex!.row]{
                DispatchQueue.main.async { [weak self] in
                    APIClient.reserveConversation(doctor_id: (self?.doctorDetails!.id)!, appointment_id: appointment.id) { (Result, Status) in
                        switch Result {
                        case .success(let response):
                            print(response)
                            if Status == 200 {
                                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "Payment") as! PaymentViewController
                                self?.navigationController?.pushViewController(vc, animated: true)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                            Alert.show("Failed".localized, massege: "Please Try Again".localized, context: self!)
                        }
                        print(Status)
                    }
                }
            } else {
                Alert.show("Error".localized, massege: "please select an appointment".localized, context: self)
            }
        } else {
        }
    }
    
    func getAppointments(){
        if let doctor = doctorDetails {
            DispatchQueue.main.async {
                [weak self] in
                APIClient.getAppointments(doctor_id: doctor.id, date: "2020-02-13") { (Result , Status) in
                    switch Result {
                    case .success(let response):
                        print(response)
                        self?.appointments = response.data
                        self?.periodesTableView.reloadData()
                        self?.checkData()
                    case.failure(let error):
                        print(error.localizedDescription)
                        self?.checkData()
                    }
                    print(Status)
                }
            }
        }
    }
    
    
    func updateView(){
        if let doctor = doctorDetails {
            doctorImage.sd_setImage(with: URL(string: doctor.image_url ), placeholderImage: UIImage(named: "imagePlaceholder"))
            doctorName.text = doctor.name
            doctorSpeciality.text = doctor.specialist
            //            hourPrice.text = doctor.
            doctorRate.rating = stringToDouble(doctor.rate)
        }
    }
    
    
    //MARK:- Check if tableView is empty and add animationview
    func checkData(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            [weak self] in
            self?.checkTableViewData(tableView: self!.periodesTableView, view: self!.backView, animationWidth: self!.backView.bounds.width+50, animationHeight: self!.backView.bounds.height+50, animationName: "NoData" , scale: .scaleAspectFit)
        }
    }
    
}

//MARK:- tableView SetUp
extension DoctorConversationViewController: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments?.count ?? 0
    }
    
    //MARK:- cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "periodCell", for: indexPath) as! PeriodsTableViewCell
        if appointments!.count >= indexPath.row+2 {
            if let from = appointments?[indexPath.row].time ,let to = appointments?[indexPath.row + 1].time {
                cell.period.attributedText = NSAttributedString.withMultibleTexts(text1: "From".localized, text2: from, text3: "to".localized, text4: to)
            }
        } else {
            if let from = appointments?[indexPath.row].time {
                cell.period.text = "From".localized + " " + from
            }
        }
        return cell
    }
    
    //MARK:- Check And Uncheck Period Boxs
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath
        if previousIndex == nil{
            previousIndex = currentIndex
            let cell = tableView.cellForRow(at: currentIndex!) as! PeriodsTableViewCell
            cell.checkBox.on = true
            
        } else if previousIndex != currentIndex , previousIndex != nil{
            let cell = tableView.cellForRow(at: currentIndex!) as! PeriodsTableViewCell
            cell.checkBox.on = true
            let pastCell = tableView.cellForRow(at: previousIndex!) as! PeriodsTableViewCell
            pastCell.checkBox.on = false
            previousIndex = currentIndex
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK:- Set Dynamic Hieght For Row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.periodesTableView.estimatedRowHeight = 50
        return UITableView.automaticDimension
    }
    
}
