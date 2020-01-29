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
            self.imageBackView.layer.cornerRadius = self.imageBackView.frame.height/2
            self.imageBackView.layer.borderColor = UIColor.gray.cgColor
            self.imageBackView.layer.borderWidth = 2
        }
    }
    @IBOutlet weak var backView: UIView!
    
    var currentIndex:IndexPath?
    var previousIndex:IndexPath?
    var new = 0
    var periods: [String]?
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
        checkData()
        DispatchQueue.main.asyncAfter(deadline: .now()+6) { [weak self] in
            self?.periods = ["From 1.30 pm to 2 pm" ,"From 2 pm to 2.30 pm" ,"From 2.30 pm to 3 pm"]
            self?.periodesTableView.reloadData()
            self?.checkData()
        }
    }
    
    //MARK:- Complete Request
    @IBAction func completeRequestPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Payment") as! PaymentViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func checkData(){
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            [weak self] in
            self?.checkTableViewData(tableView: self!.periodesTableView, view: self!.backView, animationWidth: self!.backView.bounds.width+50, animationHeight: self!.backView.bounds.height+50, animationName: "NoData" , scale: .scaleAspectFit)
        }
    }
    
}

//MARK:- tableView SetUp
extension DoctorConversationViewController: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return periods?.count ?? 0
    }
    
    //MARK:- cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "periodCell", for: indexPath) as! PeriodsTableViewCell
        cell.period.text = periods?[indexPath.row]
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
