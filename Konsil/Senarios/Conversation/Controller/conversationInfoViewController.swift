//
//  conversationInfoViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/18/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

class conversationInfoViewController: UIViewController {

    @IBOutlet weak var link: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var conversationStatus: UILabel!
    @IBOutlet var redDot: [UIView]!
    
    var conversation_id: Int?
    var conversationDetails: GetConversationDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundDots()
        conversation_id = ConversationDetailsViewController.conversation_id
        getData()
    }
    
    func getData(){
        if let id = conversation_id {
            DispatchQueue.global().async { [weak self] in
                APIClient.getConversationDetails(conversation_id: id) { (Result, Status) in
                    switch Result {
                    case .success(let response):
                        print(response)
                        if response.status == 200 {
                            self?.conversationDetails = response
                            self?.updateView()
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func updateView(){
        if let conversation = conversationDetails {
            let details = conversation.data
            link.text = details.conversation_link
            name.text = details.doctor
            conversationStatus.text = details.status
            date.text = details.date
            duration.text = details.time
        }
    }
    
    func roundDots(){
        for i in redDot.indices {
            redDot[i].layer.cornerRadius = redDot[i].frame.width/2
        }
    }
    
    

}
