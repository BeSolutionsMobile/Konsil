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
            self.messageTF.layer.cornerRadius = 10
            self.messageTF.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            self.messageTF.layer.borderColor = UIColor.gray.cgColor
            self.messageTF.layer.borderWidth = 1.5
            self.messageTF.clipsToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
    }
    
}

//MARK:- tableView setUp
extension ComplaintDetailsViewController: UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComplaintCell", for: indexPath) as! ComplaintTableViewCell
        
        return cell
    }
    
    
}
