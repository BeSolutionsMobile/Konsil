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
            Rounded.roundedCornerTextField(textField: self.messageTF, borderColor: UIColor.gray.cgColor, radius: self.messageTF.frame.height/2 , borderWidth: 1.5)
            self.messageTF.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        }
    }
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var backView: UIView!
    var Chats = 0
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
        
        messagesTableView.setContentOffset(CGPoint(x: 0, y: CGFloat.greatestFiniteMagnitude + 30), animated: false)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now()+2) { [weak self] in
            self?.checkTable()
        }
    }
    
    @IBAction func requestOnlineConversationPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "DoctorConversation") as! DoctorConversationViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func sendMessagePressed(_ sender: UIButton) {
        if messageTF.text != "" && messageTF.text != nil {
            
            Chats += 1
            messagesTableView.reloadData()
            checkTable()
        }
    }
}

//MARK:- tableView setUp
extension ConsultationMessagesViewController: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Chats
    }
    
    //MARK:- cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessagesTableViewCell
        
        cell.message.text = "chat"
        cell.name.text = "chat"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 130
        return UITableView.automaticDimension
    }
    
    func checkTable(){
        checkTableViewData(tableView: messagesTableView, view:backView, animationWidth: 300, animationHeight: 300, animationName: "Chat")
    }
}
