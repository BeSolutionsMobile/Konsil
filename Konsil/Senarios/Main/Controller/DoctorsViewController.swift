//
//  DoctorsViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/16/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import Cosmos
import BEMCheckBox
import SideMenu
class DoctorsViewController: UIViewController {
    
    @IBOutlet weak var doctorTableView: UITableView!
    
    var doctors: [Doctor]?
    var specialityID: Int?
    var degrees: [Degree]?
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getSpecialites()
    }
    
    
    //MARK:- Filter Button
    @IBAction func filterButPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Filter") as? FilterViewController {
            vc.modalPresentationStyle = .overFullScreen
            vc.delegate = self
            vc.degrees = self.degrees
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    func getSpecialites() {
        if let speciality_id = specialityID {
            APIClient.specialityDoctors(speciality_id: speciality_id) { (Result, status) in
                DispatchQueue.main.async { [weak self] in
                    switch Result {
                    case .success(let response):
                        print(response)
                        self?.doctors = response.doctors
                        self?.degrees = response.degrees
                        self?.doctorTableView.reloadData()
                        self?.checkTableViewData()
                    case .failure(let error):
                        self?.checkTableViewData()
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    func checkTableViewData(){
        EmptyTableView.emptyDataWithImage(TabelView: doctorTableView, Image: UIImage(named: "Doctors")!, View: self.view, MessageText: "no doctors available".localized)
    }
}


//MARK:- TableView SetUp
extension DoctorsViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctors?.count ?? 0
    }
    
    //MARK:- cellForRow
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorsCell", for: indexPath) as! DoctorsTableViewCell
        if let doctor = doctors?[indexPath.row] {
            cell.drName.text = doctor.name
            cell.drDegree.text = doctor.degree
            cell.drRating.rating = stringToDouble(doctor.rate)
            cell.languages.text = doctor.lang
            cell.drImage.sd_setImage(with: URL(string: doctor.image_url), placeholderImage: UIImage(named: "doctorPlaceholder"), options: .retryFailed) { (image, error, type, url) in
                cell.indicator.stopAnimating()
            }
        }
        return cell
        
    }
    
    //MARK:- didSelectRow
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DoctorInfo") as? DoctorsInfoViewController {
            vc.doctorID = doctors?[indexPath.row].id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //MARK:- heightForRow
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

//MARK:- FilterData
extension DoctorsViewController: FilterDoctorsDelegate {
    func updateData(degree: [Int], rate: Int) {
        if let specialityID = specialityID {
            DispatchQueue.main.async { [weak self] in
                APIClient.filterDoctors(speciality_id: specialityID, degree_id: degree, rate: rate) { (result, status) in
                    switch result {
                    case .success(let response):
                        print(response)
                        self?.doctors = response.doctors
                        self?.doctorTableView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
