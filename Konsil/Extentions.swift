import UIKit
import SideMenu
import Lottie
////MARK:- StatusBar background view to change statusBar background color
//extension UIApplication {
//var statusBarUIView: UIView? {
//    if #available(iOS 13.0, *) {
//        let tag = 3848245
//
//        let keyWindow = UIApplication.shared.connectedScenes
//            .map({$0 as? UIWindowScene})
//            .compactMap({$0})
//            .first?.windows.first
//        if let statusBar = keyWindow?.viewWithTag(tag) {
//            return statusBar
//        } else {
//            let height = keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
//            let statusBarView = UIView(frame: height)
//            statusBarView.tag = tag
//            statusBarView.layer.zPosition = 999999
//
//            keyWindow?.addSubview(statusBarView)
//            return statusBarView
//        }
//    } else {
//        if responds(to: Selector(("statusBar"))) {
//            return value(forKey: "statusBar") as? UIView
//        }
//    }
//    return nil
//  }
//}

//MARK:- navigationBar Buttons
extension UIViewController {
    func rightBackBut() {
        navigationItem.hidesBackButton = true
        let rightBack = UIBarButtonItem(title: "", style: .done,target: self, action: #selector(addTapped))
        rightBack.image = UIImage(named: "rightArrow")
        navigationItem.rightBarButtonItem = rightBack
        let menuBut = UIBarButtonItem(title: "", style: .done,target: self, action: #selector(showMenu))
        menuBut.image = UIImage(named: "menuButton")
        navigationItem.leftBarButtonItem = menuBut
    }
    
    @objc func addTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func showMenu(){
        let vc = storyboard?.instantiateViewController(identifier: "SideMenu") as! SideMenuNavigationController
        vc.modalPresentationStyle = .overFullScreen
        vc.settings = Shared.settings(view: self.view)
        self.present(vc, animated: true, completion: nil)
    }
    
    func presentViewControllerWithTransition(viewController: UIViewController ,animated: Bool ,direction: CATransitionSubtype ){
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        transition.subtype = direction
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(viewController, animated: animated, completion: nil)
    }
    
}
