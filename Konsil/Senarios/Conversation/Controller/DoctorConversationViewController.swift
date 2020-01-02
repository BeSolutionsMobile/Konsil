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
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
        emptyTableView()
        DispatchQueue.main.asyncAfter(deadline: .now()+4) {
            self.new = 4
            self.periodesTableView.reloadData()
            self.emptyTableView()
        }
    }
    
    //MARK:- Complete Request
    @IBAction func completeRequestPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ConversationDetails") as! ConversationDetailsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK:- tableView SetUp
extension DoctorConversationViewController: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return new
    }
    
    //MARK:- cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "periodCell", for: indexPath) as! PeriodsTableViewCell
        cell.period.text = "new Period new Period new Period new Period new Period new Period new Period"
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
    
    func emptyTableView(){
        let view = UIView()
        view.frame = backView.bounds
        view.tag = 999
        if periodesTableView.numberOfRows(inSection: 0) == 0 {
            let animation = Shared.showLottie(view: view, fileName: "lf30_editor_oj5Gth", contentMode: .center)
            view.addSubview(animation)
            backView.addSubview(view)
            animation.play()
        } else {
            backView.viewWithTag(999)?.removeFromSuperview()
        }
    }
}
