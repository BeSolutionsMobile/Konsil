//
//  ConsultationDetailsViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/17/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

class ConsultationDetailsViewController: UIViewController {
    @IBOutlet weak var segmantController: UISegmentedControl!{
        didSet{
            self.customizeSigmanted(for: self.segmantController)
        }
    }
    
    @IBOutlet weak var backGroundView: UIView!
    weak var currentViewController : UIViewController?
    
    static var consultation_id: Int?
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
        setDefaultView()
    }
    
    //MARK:- change viewController's view by adding other viewController's view
    @IBAction func changeView(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "ConsultationMessages")
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            
            self.cycleFromViewController(oldViewController: self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
        } else if sender.selectedSegmentIndex == 1 {
            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "ConsultationFinalReport")
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            
            self.cycleFromViewController(oldViewController: self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
        } else {
            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "ConsultationFiles")
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            
            self.cycleFromViewController(oldViewController: self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
            
        }
    }
    
    //MARK:- add other viewContoller's view
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
        self.addSubview(subView: newViewController.view, toView:self.backGroundView!)
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
    
    
    //MARK:- Default segmant view
    func setDefaultView(){
        self.currentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ConsultationMessages")
        self.currentViewController?.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(self.currentViewController!)
        self.addSubview(subView: self.currentViewController!.view, toView: self.backGroundView)
    }
    
    //MARK:- Customize Segmant Controller
    func customizeSigmanted(for segmantController: UISegmentedControl) {
        if #available(iOS 13.0, *) {
            let titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]
            
            let selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white , NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold)]
            
            segmantController.setTitleTextAttributes(titleTextAttributes, for: .normal)
            segmantController.setTitleTextAttributes(selectedTitleTextAttributes, for: .selected)
            
            let divider = UIImage(named: "SegmantSeparator")
            segmantController.setDividerImage(divider, forLeftSegmentState: [.normal , .selected], rightSegmentState: [.normal , .selected], barMetrics: .default)
        } else {
            segmantController.tintColor = UIColor(red: 0.867, green: 0.206, blue: 0.159, alpha: 1)
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray ,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]
            
            let selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white , NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold)]
            
            segmantController.setTitleTextAttributes(titleTextAttributes, for: .normal)
            segmantController.setTitleTextAttributes(selectedTitleTextAttributes, for: .selected)
        }
    }
    
}
