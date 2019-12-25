//
//  MyConsultationsViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/19/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

class MyConsultationsViewController: UIViewController {

    @IBOutlet weak var myConsultationTableView: UITableView!{
        didSet {
            self.myConsultationTableView.rowHeight = UITableView.automaticDimension
            self.myConsultationTableView.estimatedRowHeight = 110
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
    }

}

//MARK:- tableView Setup
extension MyConsultationsViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyConsultationsCell", for: indexPath) as! MyConsultationsTableViewCell
        
        return cell
    }
    
}
