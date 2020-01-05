//
//  ComplaintDetailsViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/19/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

class ComplaintDetailsViewController: UIViewController {

    @IBOutlet weak var compliantStatus: UILabel!
    @IBOutlet weak var sendBut: UIButton!{
        didSet{
            self.sendBut.layer.cornerRadius = 10
            self.sendBut.layer.maskedCorners = [.layerMaxXMaxYCorner , .layerMaxXMinYCorner]
        }
    }
    @IBOutlet weak var messageTF: UITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.messageTF, borderColor: UIColor.gray.cgColor, radius: 10  , borderWidth: 1.5)
            self.messageTF.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        }
    }
    @IBOutlet weak var complaintTableView: UITableView!{
        didSet{
            complaintTableView.estimatedRowHeight = 130
            complaintTableView.rowHeight = UITableView.automaticDimension
        }
    }
    @IBOutlet weak var backView: UIView!
    
    
    var Chats = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
        checkTableView()
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        if messageTF.text != "" && messageTF.text != nil {
            Chats += 1
            complaintTableView.reloadData()
            checkTableView()
        }
    }
    
}

//MARK:- tableView setUp
extension ComplaintDetailsViewController: UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Chats
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComplaintCell", for: indexPath) as! ComplaintTableViewCell
        cell.message.text = "sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss"
        cell.name.text = "aaaasssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 130
        return UITableView.automaticDimension
    }
    
    func checkTableView(){
        checkTableViewData(tableView: complaintTableView , view: backView, animationWidth: 300, animationHeight: 300, animationName: "Chat")
    }
    
    
    
}
