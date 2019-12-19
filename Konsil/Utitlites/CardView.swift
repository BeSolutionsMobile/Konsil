
import UIKit

@IBDesignable
class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 3
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.lightGray
    @IBInspectable var shadowOpacity: Float = 0.5
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
}

class ProfileImageView: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 1
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 0
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.5
    
    override func layoutSubviews() {
        layer.cornerRadius = (frame.width) / 2
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
}
struct Rounded {
    static func topLeft(view: UIView){
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.maskedCorners = .layerMinXMinYCorner
    }
    static func topRight(view: UIView){
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.maskedCorners = .layerMaxXMinYCorner
    }
    static func botLeft(view: UIView){
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.maskedCorners = .layerMinXMaxYCorner
    }
    static func botRight(view: UIView){
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.maskedCorners = .layerMaxXMaxYCorner
    }
    static func normalView(view: UIView){
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.lightGray.cgColor
    }
    static func roundedCornerButton(button: UIButton) {
        button.layer.cornerRadius = button.frame.height / 2
        button.layer.shadowRadius = 2
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        button.layer.shadowOpacity = 0.3
    }
    
    static func roundButton(button: UIButton) {
        button.layer.cornerRadius = button.frame.height / 2
        button.layer.shadowRadius = 3
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2.5)
        button.layer.shadowOpacity = 0.4
    }
    
    static func roundedCornerTextField(textField: UITextField){
        textField.layer.cornerRadius = textField.frame.height/2
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.borderWidth = 1.5
        textField.clipsToBounds = true
    }
    
    static func profileRoundedCornerTextField(textField: UITextField){
        textField.layer.cornerRadius = textField.frame.height/2
        textField.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        textField.layer.borderWidth = 1.5
        textField.clipsToBounds = true
    }
    
    static func roundedImage(imageView: UIImageView){
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = #colorLiteral(red: 0.1999711692, green: 0.2000181675, blue: 0.1999708116, alpha: 1)
    }
}



struct EmptyTableView {
    static func emptyDataWithImage(TabelView: UITableView , Image: UIImage ,View: UIView ,MessageText: String) {
        let errorView = UIView(frame: CGRect(x: 0, y: 0, width: View.frame.width, height: View.frame.height))
        if TabelView.numberOfRows(inSection: 0) == 0 {
            errorView.tag = 100
            errorView.backgroundColor = .white
            let image = UIImageView(frame: CGRect(x: errorView.frame.width / 2 - 100 , y: errorView.frame.height / 2 - 100, width: 200 , height: 200))
            image.image = Image
            
            let message = UILabel(frame: CGRect(x: errorView.frame.width/2 - 100
                , y: errorView.frame.height/2 + 100, width: 200, height: 25))
            message.text = MessageText
            message.textColor = .red
            message.textAlignment = .center
            message.font = UIFont(name: "Futura-Bold", size: 20)
            
            errorView.addSubview(image)
            errorView.addSubview(message)
            View.addSubview(errorView)
        }
        else{
            if let viewWithTag = View.viewWithTag(100) {
                viewWithTag.removeFromSuperview()
            }
        }
    }
    
    
    static func emptyData(TabelView: UITableView ,View: UIView ,MessageText: String) {
        let errorView = UIView(frame: CGRect(x: 0, y: 0, width: View.frame.width, height: View.frame.height))
        if TabelView.numberOfRows(inSection: 0) == 0 {
            errorView.tag = 100
            errorView.backgroundColor = .white
            
            
            let message = UILabel(frame: CGRect(x: errorView.frame.width/2 - 200
                , y: errorView.frame.height/2 , width: 400, height: 25))
            message.text = MessageText
            message.textColor = .darkGray
            message.textAlignment = .center
            message.font = UIFont(name: "Futura-Normal", size: 20)
            
            
            errorView.addSubview(message)
            View.addSubview(errorView)
        }
        else{
            if let viewWithTag = View.viewWithTag(100) {
                viewWithTag.removeFromSuperview()
            }
        }
    }
}
