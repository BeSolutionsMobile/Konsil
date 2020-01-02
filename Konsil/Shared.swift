import SideMenu
import Lottie
class Shared {
    static var BiometricAuthEnabled:Bool = false{
        didSet{
            if self.BiometricAuthEnabled == true {
                print("Biometric enabled")
            } else if self.BiometricAuthEnabled == false {
                print("Biometric disabled")
            }
        }
    }
    
    static func settings(view: UIView) -> SideMenuSettings {
        let presentationStyle = SideMenuPresentationStyle.menuSlideIn
        presentationStyle.backgroundColor = .white
        var settings = SideMenuSettings()
        settings.presentationStyle = presentationStyle
        settings.statusBarEndAlpha = 0
        settings.menuWidth = view.frame.width-view.frame.width*(1/3)
        
        return settings
    }
    
    static func showLottie(view: UIView ,fileName: String ,contentMode: UIView.ContentMode? = .scaleAspectFill) -> AnimationView {
        let animation = Animation.named(fileName)
        let lotView = AnimationView()
        lotView.animation = animation
        lotView.contentMode = contentMode ?? .scaleAspectFill
        lotView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lotView)
        
        NSLayoutConstraint.activate([
            lotView.heightAnchor.constraint(equalTo: view.heightAnchor) ,
            lotView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        return lotView
    }
    
    
}
