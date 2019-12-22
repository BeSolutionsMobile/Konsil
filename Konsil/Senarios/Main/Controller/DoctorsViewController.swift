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
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
        
    }
    
    
    //MARK:- Filter Button
    @IBAction func filterButPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "Filter") as! FilterViewController
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}


//MARK:- TableView SetUp
extension DoctorsViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    //MARK:- cellForRow
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorsCell", for: indexPath) as! DoctorsTableViewCell
        
        return cell
    }
    
    //MARK:- didSelectRow
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DoctorInfo") as! DoctorsInfoViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- heightForRow
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
