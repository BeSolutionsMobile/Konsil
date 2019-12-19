//
//  ConversationDetailsViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/18/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

class ConversationDetailsViewController: UIViewController {
    
    @IBOutlet weak var segmantedController: UISegmentedControl!{
        didSet{
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black , NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]
            let selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white , NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold)]
            segmantedController.setTitleTextAttributes(titleTextAttributes, for: .normal)
            segmantedController.setTitleTextAttributes(selectedTitleTextAttributes, for: .selected)
            let divider = UIImage(named: "de")
            segmantedController.setDividerImage(divider, forLeftSegmentState: [.normal , .selected], rightSegmentState: [.normal , .selected], barMetrics: .default)
        }
    }
    @IBOutlet weak var contentView: UIView!
    
    weak var currentViewController : UIViewController?
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
        
        self.currentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ConversationIfno")
        self.currentViewController?.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(self.currentViewController!)
        self.addSubview(subView: self.currentViewController!.view, toView: self.contentView)
    }
    
    
    @IBAction func changeView(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "ConversationIfno")
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            
            self.cycleFromViewController(oldViewController: self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
        } else if sender.selectedSegmentIndex == 1 {
            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "ConversattionReport")
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            
            self.cycleFromViewController(oldViewController: self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
        }
    }
    
    func addSubview(subView:UIView, toView parentView:UIView) {
        parentView.addSubview(subView)
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|",
                                                                 options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|",
                                                                 options: [], metrics: nil, views: viewBindingsDict))
    }
    
    func cycleFromViewController(oldViewController: UIViewController, toViewController newViewController: UIViewController) {
        oldViewController.willMove(toParent: nil)
        self.addChild(newViewController)
        self.addSubview(subView: newViewController.view, toView:self.contentView!)
        newViewController.view.alpha = 0
        newViewController.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, animations: {
            newViewController.view.alpha = 1
            oldViewController.view.alpha = 0
        },completion: { finished in
            oldViewController.view.removeFromSuperview()
            oldViewController.removeFromParent()
            newViewController.didMove(toParent: self)
        }
        )
    }
    
}
