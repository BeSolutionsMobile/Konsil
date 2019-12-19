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

    @IBOutlet weak var doctorImage: UIImageView!{
        didSet{
            self.doctorImage.layer.cornerRadius = self.doctorImage.frame.width/2
            self.doctorImage.layer.borderColor = UIColor.darkGray.cgColor
            self.doctorImage.layer.borderWidth = 2
        }
    }
    
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
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
       rightBackBut()
    }
    
    @IBAction func completeRequestPressed(_ sender: UIButton) {
    }
    
}

//MARK:- tableView SetUp
extension DoctorConversationViewController: UITableViewDataSource , UITableViewDelegate , CheckBoxDelegate {
    func choosePeriod(checkBox: BEMCheckBox, cell: UITableViewCell) {
        let myCell = cell as! PeriodsTableViewCell
        let indexPath = periodesTableView.indexPath(for: myCell)
        checkBox.on = true
        periodesTableView.reloadData()
        print("Reload")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "periodCell", for: indexPath) as! PeriodsTableViewCell
        cell.period.text = "new Period"
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
