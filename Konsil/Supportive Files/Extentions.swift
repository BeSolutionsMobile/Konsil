import UIKit
import SideMenu
import Lottie
import Network
import NVActivityIndicatorView

//MARK:- navigationBar Buttons
extension UIViewController: UITextFieldDelegate ,NVActivityIndicatorViewable{
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
    
    func stringToDouble(_ string: String) -> Double {
        guard let double = Double(string) else { return 0}
        return double
    }
    //MARK:- Navigation Bar Buttonsa
    func rightBackBut() {
        navigationItem.hidesBackButton = true
        let rightBack = UIBarButtonItem(title: "", style: .done,target: self, action: #selector(backPressed))
        
        rightBack.image = UIImage(named: "rightArrow".localized)
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
        if "Lang".localized == "ar" {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "RightSideMenuNav") as? SideMenuNavigationController {
                vc.modalPresentationStyle = .overFullScreen
                vc.settings = Shared.settings(view: self.view)
                self.present(vc, animated: true, completion: nil)
            }
        } else {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "SideMenu") as? SideMenuNavigationController {
                vc.modalPresentationStyle = .overFullScreen
                vc.settings = Shared.settings(view: self.view)
                self.present(vc, animated: true, completion: nil)
            }
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
        if tableView.numberOfRows(inSection: 0) != 0 {
            view.viewWithTag(999)?.removeFromSuperview()
        } else {
            let animation = Shared.showLottie(view: animationView, fileName: animationName, contentMode: scale)
            animationView.addSubview(animation)
            view.addSubview(animationView)
            animation.play()
        }
    }
    
    func checkAppointments(appointments: [Appointment] ,tableView: UITableView , view: UIView , animationWidth: CGFloat , animationHeight: CGFloat , animationName: String , scale: UIView.ContentMode? = .scaleToFill){
        let animationView = UIView()
        animationView.frame = CGRect(x: (view.frame.width/2) - (animationWidth/2), y: (view.frame.height/2) - (animationHeight/2), width: animationWidth, height: animationHeight)
        animationView.tag = 999
        if appointments.count == 0 {
            tableView.reloadData()
            print("1")
            let animation = Shared.showLottie(view: animationView, fileName: animationName, contentMode: scale)
            if view.viewWithTag(999)
                != nil {
                view.viewWithTag(999)?.removeFromSuperview()

            }
            animationView.addSubview(animation)
            view.addSubview(animationView)
            animation.play()
        } else {
            print("2")
            view.viewWithTag(999)?.removeFromSuperview()
            tableView.reloadData()
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

extension UITextField {
    func isError(baseColor: CGColor, numberOfShakes shakes: Float, revert: Bool) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "shadowColor")
        animation.fromValue = baseColor
        animation.toValue = UIColor.red.cgColor
        animation.duration = 0.4
        if revert { animation.autoreverses = true } else { animation.autoreverses = false }
        self.layer.add(animation, forKey: "")
        
        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = shakes
        if revert { shake.autoreverses = true } else { shake.autoreverses = false }
        shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(shake, forKey: "position")
        self.layer.borderColor = CGColor.kRed
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

extension CGColor {
    static var kRed = UIColor(red: 0.867, green: 0.206, blue: 0.159, alpha: 1).cgColor
    static var kBlue = UIColor(red: 0.020, green: 0.455, blue: 0.576, alpha: 1).cgColor
    static var kGray = UIColor(red: 0.196, green: 0.196, blue: 0.196, alpha: 1).cgColor
    static var kTrans = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
}
extension UIViewController: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter Patient History Here".localized || textView.text == "Enter Complaint Details Here".localized || textView.text == "Enter Consultation Details Here".localized {
            textView.text = ""
        }
    }
}

extension NSAttributedString {
    static func withMultibleTexts(text1: String ,text2: String ,text3: String ,text4: String) -> NSMutableAttributedString{
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: text1 + " "))
        text.append(NSAttributedString(string: text2 + " "))
        text.append(NSAttributedString(string: text3 + " "))
        text.append(NSAttributedString(string: text4 + " "))
        return text
    }
}
