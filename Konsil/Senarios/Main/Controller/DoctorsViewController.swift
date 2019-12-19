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

    
    @IBOutlet weak var doctorTableView: UITableView!{
        didSet{
            doctorTableView.rowHeight = 120
            doctorTableView.separatorStyle = .none
        }
    }
    let onConstraint: CGFloat = 420
    let offConstraint: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
        
    }
    
    @IBAction func filterButPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "Filter") as! FilterViewController
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

extension DoctorsViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorsCell", for: indexPath) as! DoctorsTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DoctorInfo") as! DoctorsInfoViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
