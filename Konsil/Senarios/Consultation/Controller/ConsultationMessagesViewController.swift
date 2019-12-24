//
//  ConsultationMessagesViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/17/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

class ConsultationMessagesViewController: UIViewController {

    @IBOutlet weak var requestChat: UIButton!{
        didSet{
            self.requestChat.layer.cornerRadius = self.requestChat.frame.height/2
        }
    }
    @IBOutlet weak var consultationStatus: UILabel!
    @IBOutlet weak var sendBut: UIButton!{
        didSet{
            self.sendBut.layer.cornerRadius = self.sendBut.frame.height/2
            self.sendBut.layer.maskedCorners = [.layerMaxXMaxYCorner , .layerMaxXMinYCorner]
        }
    }
    @IBOutlet weak var messageTF: UITextField!{
        didSet{
            self.messageTF.layer.cornerRadius = self.messageTF.frame.height/2
            self.messageTF.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            self.messageTF.layer.borderColor = UIColor.darkGray.cgColor
            self.messageTF.layer.borderWidth = 1.5
            self.messageTF.clipsToBounds = true
            
        }
    }
    @IBOutlet weak var messagesTableView: UITableView!{
        didSet{
            self.messagesTableView.estimatedRowHeight = 130
            self.messagesTableView.rowHeight = UITableView.automaticDimension
        }
    }
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
        messagesTableView.setContentOffset(CGPoint(x: 0, y: CGFloat.greatestFiniteMagnitude + 30), animated: false)
    }
    
    @IBAction func requestOnlineConversationPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "DoctorConversation") as! DoctorConversationViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func sendMessagePressed(_ sender: UIButton) {
    }
}

//MARK:- tableView setUp
extension ConsultationMessagesViewController: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    //MARK:- cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessagesTableViewCell
        
        return cell
    }
    
    
}
