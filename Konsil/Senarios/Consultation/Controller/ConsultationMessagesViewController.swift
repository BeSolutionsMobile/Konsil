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
            if "Lang".localized == "ar" {
                self.sendBut.layer.maskedCorners = [.layerMinXMinYCorner , .layerMinXMaxYCorner]
            } else {
                self.sendBut.layer.maskedCorners = [.layerMaxXMaxYCorner , .layerMaxXMinYCorner]
            }
        }
    }
    @IBOutlet weak var messageTF: UITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.messageTF, borderColor: UIColor.gray.cgColor, radius: self.messageTF.frame.height/2 , borderWidth: 1.5)
            if "Lang".localized == "ar" {
                self.messageTF.layer.maskedCorners = [.layerMaxXMaxYCorner , .layerMaxXMinYCorner]
            } else {
                self.messageTF.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            }
        }
    }
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var backView: UIView!
    var consultation_id: Int?
    var Chats = 0
    var messages: [MessageInfo]?
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        getChatMessages()
        rightBackBut()
        messagesTableView.setContentOffset(CGPoint(x: 0, y: CGFloat.greatestFiniteMagnitude + 30), animated: false)
    }
    
    //MARK:- ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now()+1) { [weak self] in
            self?.checkTable()
        }
    }
    
    //MARK:- IBAcotions
    @IBAction func requestOnlineConversationPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DoctorConversation") as? DoctorConversationViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func sendMessagePressed(_ sender: UIButton) {
        sendMessage()
    }
    
    func sendMessage(){
        if consultation_id != nil , messageTF.text != ""{
            sendBut.isEnabled = false
            let user = Shared.user
            let message = MessageInfo(id: consultation_id!, name: user?.name ?? "", user_image: user?.image_url ?? "", message: messageTF.text ?? "")
            DispatchQueue.main.async { [weak self] in
                APIClient.sendMessage(consultation_id: self?.consultation_id ?? 0 , message: self?.messageTF.text ?? "") { (Result, Status) in
                    switch Result {
                    case .success(let response):
                        print(response)
                        self?.sendBut.isEnabled = true
                        if response.status == 200 {
                            self?.messages?.append(message)
                            self?.reloadTableView()
                            self?.checkTable()
                        }
                    case .failure(let error):
                        self?.sendBut.isEnabled = true
                        print(error.localizedDescription)
                        Alert.show("Failed".localized, massege: "Message was not sent", context: self!)
                    }
                }
            }
        }
    }
    
    func reloadTableView(){
        messagesTableView.reloadData()
        guard let count = messages?.count else { return }
        let indexpath = IndexPath(row: count - 1, section: 0)
        if messages?.count != 0 {
            DispatchQueue.main.async { [weak self] in
                self?.messagesTableView.scrollToRow(at: indexpath, at: .bottom, animated: true)
            }
        }
        
    }
    
    func getChatMessages(){
        consultation_id = ConsultationDetailsViewController.consultation_id
        if consultation_id != nil {
            DispatchQueue.main.async { [weak self] in
                APIClient.getChatMessages(consultaion_id: (self?.consultation_id)!) { (Result, Status) in
                    switch Result {
                    case .success(let response):
                        print(response)
                        self?.messages = response.messages
                        self?.reloadTableView()
                    case .failure(let error):
                        print(error.localizedDescription)
                        Alert.show("Error".localized, massege: "Can't Load Messages", context: self!)
                    }
                }
            }
        }
    }
}

//MARK:- tableView setUp
extension ConsultationMessagesViewController: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    //MARK:- cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessagesTableViewCell
        if let message = messages?[indexPath.row]{
            cell.cellImage.sd_setImage(with: URL(string: message.user_image), placeholderImage: UIImage(named: "userPlaceholder"))
            cell.message.text = message.message
            cell.name.text = message.name
        }
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
