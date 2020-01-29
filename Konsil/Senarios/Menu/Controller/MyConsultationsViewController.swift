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
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
    }

}

//MARK:- tableView Setup
extension MyConsultationsViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyConsultationsCell", for: indexPath) as! MyConsultationsTableViewCell
        cell.doctorName.text = name[indexPath.row]
        cell.price.text = prie[indexPath.row]
        cell.doctorImage.image = UIImage(named: images[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if #available(iOS 13.0, *) {
            if let vc = storyboard?.instantiateViewController(identifier: "consultationDetails") as? ConsultationDetailsViewController {
                vc.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
}
