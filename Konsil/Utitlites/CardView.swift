
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
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.maskedCorners = .layerMinXMinYCorner
    }
    
    static func topRight(view: UIView){
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.maskedCorners = .layerMaxXMinYCorner
    }
    
    static func botLeft(view: UIView){
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.maskedCorners = .layerMinXMaxYCorner
    }
    
    static func botRight(view: UIView){
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.maskedCorners = .layerMaxXMaxYCorner
    }
    
    static func normalView(view: UIView){
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
    }
    
    static func roundButton(button: UIButton ,radius: CGFloat ,borderColor: CGColor? = nil , borderWidth: CGFloat? = 0 ) {
        button.layer.cornerRadius = radius
        button.layer.borderColor = borderColor
        button.layer.borderWidth = borderWidth ?? 0
    }
    
    static func roundedCornerTextField(textField: UITextField ,borderColor: CGColor ,radius: CGFloat ,borderWidth: CGFloat? = 1.5){
        textField.layer.cornerRadius = radius
        textField.layer.borderColor = borderColor
        textField.layer.borderWidth = borderWidth ?? 1.5
        textField.clipsToBounds = true
    }
    
    static func roundedImage(imageView: UIImageView ,radius: CGFloat ,borderColor: CGColor ,borderWidth: CGFloat){
        imageView.layer.cornerRadius = radius
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = borderWidth
        imageView.layer.borderColor = borderColor
    }
    
    static func roundedDots(Dots: [UIView]){
        for i in Dots.indices {
            Dots[i].layer.cornerRadius = Dots[i].frame.width/2
        }
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
