//
//  Walkthrough1ViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 1/1/20.
//  Copyright © 2020 begroup. All rights reserved.
//

import UIKit

class Walkthrough1ViewController: UIViewController {
    
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
    
    func setUpAnimations(){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            let animation = Shared.showLottie(view: self.animationView, fileName: Animations.lifeLine)
            animation.animationSpeed = 0.7
            animation.play()
        }
    }
    
    func swipToSigue(){
        let swipeToLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swipeToLeft.direction = .left
        self.view.addGestureRecognizer(swipeToLeft)
        
    }

    @objc func swipeAction(){
        if #available(iOS 13.0, *) {
            if let vc = storyboard?.instantiateViewController(identifier: "Walkthrough2") as? Walkthrough2ViewController {
                vc.modalPresentationStyle = .fullScreen
                presentViewControllerWithTransition(viewController: vc, animated: true, direction: .fromRight)
            }
        }
    }
}

