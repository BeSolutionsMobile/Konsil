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
    
    var name = ["Ahmed Khalil" , "Mahmoud Saber" , "Nour" , "Wael Mansour" , "Mahmoud Samir" , "Nermeen Fouad" , "Ramy El Badry" , "Naser Ali" , "Ali Essa" , "Adham Samir"]
    var deg = ["Specialist" , "Advisory" , "Professor" , "Specialist"  , "Professor" , "Advisory" , "Specialist" , "Advisory" , "Professor" , "Advisory"]
    var images = ["1" , "2" , "3" , "4"  , "5" , "6" , "7" , "8" , "9" , "10"]
    var rate = [4 , 3.5 , 4.5 ,2.5 ,4 , 3 , 4 , 3.5 , 3, 2.5]
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
    }
    
    
    //MARK:- Filter Button
    @IBAction func filterButPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Filter") as? FilterViewController {
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false, completion: nil)
        }
    }
}


//MARK:- TableView SetUp
extension DoctorsViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    //MARK:- cellForRow
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorsCell", for: indexPath) as! DoctorsTableViewCell
        cell.drName.text = name[indexPath.row]
        cell.drDegree.text = deg[indexPath.row]
        cell.drRating.rating = rate[indexPath.row]
        cell.drImage.image = UIImage(named: images[indexPath.row])
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
