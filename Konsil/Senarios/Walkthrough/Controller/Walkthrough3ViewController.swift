//
//  Walkthrough3ViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 1/1/20.
//  Copyright © 2020 begroup. All rights reserved.
//

import UIKit

class Walkthrough3ViewController: UIViewController {
    
    @IBOutlet weak var startBut: UIButton!{
        didSet{
            Rounded.roundButton(button: self.startBut, radius: self.startBut.frame.height/2 , borderColor: UIColor.gray.cgColor , borderWidth: 1.5)
        }
    }
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
        if #available(iOS 13.0, *) {
            if let vc = storyboard?.instantiateViewController(identifier: "LogIn") as? LogInViewController {
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func startPressed(_ sender: UIButton) {
        if #available(iOS 13.0, *) {
            if let vc = storyboard?.instantiateViewController(identifier: "LogIn") as? LogInViewController {
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
            }
        }
        
    }
    func setUpAnimations(){
        let animation = Shared.showLottie(view: self.animationView, fileName: Animations.doctor)
        animation.play()
    }
    
    func swipToSigue(){
        let swipeToLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swipeToLeft.direction = .left
        self.view.addGestureRecognizer(swipeToLeft)
        
        let swipeToRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swipeToRight.direction = .right
        self.view.addGestureRecognizer(swipeToRight)
    }
    
    @objc func swipeAction(_ sender: UISwipeGestureRecognizer){
        if sender.direction == .right {
            if #available(iOS 13.0, *) {
                if let vc = storyboard?.instantiateViewController(identifier: "Walkthrough2") as? Walkthrough2ViewController {
                    vc.modalPresentationStyle = .fullScreen
                    presentViewControllerWithTransition(viewController: vc, animated: true, direction: .fromRight)
                }
            }
        } else if sender.direction == .left {
            if #available(iOS 13.0, *) {
                if let vc = storyboard?.instantiateViewController(identifier: "LogIn") as? LogInViewController {
                    vc.modalPresentationStyle = .fullScreen
                    
                    present(vc, animated: true, completion: nil)
                }
            }
        }
    }
}
