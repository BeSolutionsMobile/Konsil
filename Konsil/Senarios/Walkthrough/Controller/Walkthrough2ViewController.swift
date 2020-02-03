//
//  Walkthrough2ViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 1/1/20.
//  Copyright © 2020 begroup. All rights reserved.
//

import UIKit

class Walkthrough2ViewController: UIViewController {
    
    @IBOutlet var redDots: [UIView]!{
        didSet{
            Rounded.roundedDots(Dots: redDots)
        }
    }
    @IBOutlet weak var animationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAnimations()
        swipToSigue()
    }
    
    @IBAction func skipPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "LogIn") as? LogInViewController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    func setUpAnimations(){
        
        let animation = Shared.showLottie(view: self.animationView, fileName: Animations.report , contentMode: .scaleAspectFit)
        animation.play()
        
    }
    
    func swipToSigue(){
        let swipeToLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeToLeft.direction = .left
        self.view.addGestureRecognizer(swipeToLeft)
        
        let swipeToRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeToRight.direction = .right
        self.view.addGestureRecognizer(swipeToRight)
    }
    
    @objc func swipeAction(_ sender: UISwipeGestureRecognizer){
        if sender.direction == .right {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Walkthrough1") as? Walkthrough1ViewController {
                vc.modalPresentationStyle = .fullScreen
                presentViewControllerWithTransition(viewController: vc, animated: true, direction: .fromRight)
            }
        } else if sender.direction == .left {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Walkthrough3") as? Walkthrough3ViewController {
                vc.modalPresentationStyle = .fullScreen
                presentViewControllerWithTransition(viewController: vc, animated: true, direction: .fromLeft)
            }
        }
    }
}
