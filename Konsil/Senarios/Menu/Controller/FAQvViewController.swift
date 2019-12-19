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
        faqTableView.estimatedRowHeight = 60
        faqTableView.rowHeight = UITableView.automaticDimension
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
}

//MARK:- DropDown Delegate
extension FAQvViewController: DropDownDelegate {
    func updateView(label: UILabel, textField: DesignableUITextField) {
        if label.text == "" {
            textField.rightImage = #imageLiteral(resourceName: "minus")
            label.text = "quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. E"
            UIView.animate(withDuration: 0.9) {
                self.view.layoutIfNeeded()
            }
        } else {
            textField.rightImage = #imageLiteral(resourceName: "plus")
            label.text = ""
        }
        
        faqTableView.estimatedRowHeight = 60
        faqTableView.rowHeight = UITableView.automaticDimension
        faqTableView.reloadData()
        
    }
}
