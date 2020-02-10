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
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    func getSpecialites() {
        if let speciality_id = specialityID {
            APIClient.specialityDoctors(speciality_id: speciality_id) { (Result, status) in
                DispatchQueue.main.async { [weak self] in
                    switch Result {
                    case .success(let response):
                        self?.doctors = response.doctors
                        self?.doctorTableView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    print("Status: ",status)
                }
            }
        }
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
            cell.drImage.sd_setHighlightedImage(with: URL(string: doctor.image_url), options: .delayPlaceholder)
        }
        return cell
    }
    
    //MARK:- didSelectRow
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DoctorInfo") as? DoctorsInfoViewController {
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
