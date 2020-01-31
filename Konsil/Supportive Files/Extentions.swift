import UIKit
import SideMenu
import Lottie
import Network

//MARK:- navigationBar Buttons
extension UIViewController: UITextFieldDelegate{
    func topViewController() -> UIViewController! {
        if self.isKind(of: UITabBarController.self) {
            let tabbarController =  self as! UITabBarController
            return tabbarController.selectedViewController!.topViewController()
        } else if (self.isKind(of: UINavigationController.self)) {
            let navigationController = self as! UINavigationController
            return navigationController.visibleViewController!.topViewController()
        } else if ((self.presentedViewController) != nil){
            let controller = self.presentedViewController
            return controller!.topViewController()
        } else {
            return self
        }
    }
    
    //MARK:- Navigation Bar Buttonsa
    func rightBackBut() {
        navigationItem.hidesBackButton = true
        let rightBack = UIBarButtonItem(title: "", style: .done,target: self, action: #selector(backPressed))
        rightBack.image = UIImage(named: "rightArrow")
        navigationItem.rightBarButtonItem = rightBack
        let menuBut = UIBarButtonItem(title: "", style: .done,target: self, action: #selector(showMenu))
        menuBut.image = UIImage(named: "menuButton")
        navigationItem.leftBarButtonItem = menuBut
    }
    //MARK:-
    @objc func backPressed(){
        navigationController?.popViewController(animated: true)
    }
    //MARK:- Menu Button Action
    @objc func showMenu(){
            if let vc = storyboard?.instantiateViewController(withIdentifier: "SideMenu") as? SideMenuNavigationController {
                vc.modalPresentationStyle = .overFullScreen
                vc.settings = Shared.settings(view: self.view)
                self.present(vc, animated: true, completion: nil)
            }
    
        
    }
    
    //MARK:- Segue Fade Transition
    func presentViewControllerWithTransition(viewController: UIViewController ,animated: Bool ,direction: CATransitionSubtype ){
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        transition.subtype = direction
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(viewController, animated: animated, completion: nil)
    }
    
    //MARK:- Check TableView Empty Or Not
    func checkTableViewData(tableView: UITableView , view: UIView , animationWidth: CGFloat , animationHeight: CGFloat , animationName: String , scale: UIView.ContentMode? = .scaleToFill){
        let animationView = UIView()
        animationView.frame = CGRect(x: (view.frame.width/2) - (animationWidth/2), y: (view.frame.height/2) - (animationHeight/2), width: animationWidth, height: animationHeight)
        animationView.tag = 999
        if tableView.numberOfRows(inSection: 0) == 0 {
            let animation = Shared.showLottie(view: animationView, fileName: animationName, contentMode: scale)
            animationView.addSubview(animation)
            view.addSubview(animationView)
            animation.play()
        } else {
            view.viewWithTag(999)?.removeFromSuperview()
        }
    }
    
    //MARK:- Dismiss TextField on Pressing Return Key
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:- StatusBar background view to change statusBar background color
    
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
}

//MARK:- Return Localized Version of String
extension String {
    var localized : String {
        return NSLocalizedString(self, comment: "")
    }
}
