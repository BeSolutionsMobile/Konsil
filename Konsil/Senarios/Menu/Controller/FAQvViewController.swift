//
//  FAQvViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/18/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

class FAQvViewController: UIViewController {
    
    @IBOutlet weak var faqTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
    }
    
}

//MARK:- tableview SetUp
extension FAQvViewController : UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FAQTableViewCell
        
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = Bundle.main.loadNibNamed("SectionHeaderView", owner: self, options: nil)?.first as! SectionHeaderView
        sectionHeader.headerLabel.text = "Group \(section+1)"
        return sectionHeader
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 60
        return UITableView.automaticDimension
    }
}

//MARK:- DropDown Delegate , open FAQ item and show it's details
extension FAQvViewController: DropDownDelegate {
    func updateView(label: UILabel, textField: DesignableUITextField) {
        if label.text == "" {
            textField.rightImage = #imageLiteral(resourceName: "Minus")
            textField.textColor = #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1)
            label.text = "quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. E"
        } else {
            textField.rightImage = #imageLiteral(resourceName: "Plus")
            textField.textColor = #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 1)
            label.text = ""
        }
        faqTableView.estimatedRowHeight = 60
        faqTableView.rowHeight = UITableView.automaticDimension
        faqTableView.reloadData()
        
    }
}
