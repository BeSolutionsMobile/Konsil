//
//  LanguagesViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 2/23/20.
//  Copyright © 2020 begroup. All rights reserved.
//

import UIKit
import MOLH

class LanguagesViewController: UIViewController {

    @IBOutlet weak var backView: CardView!{
        didSet{
            self.backView.clipsToBounds = false
        }
    }
    @IBOutlet weak var languageLbl: UILabel!{
        didSet{
            self.languageLbl.text = "Select Language".localized
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapRecognizer()
    }
    
    func addTapRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissOnTap))
        let viewGestureRecognizer = UITapGestureRecognizer(target: self, action: nil)
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
        backView.addGestureRecognizer(viewGestureRecognizer)
    }
    
    @objc func dismissOnTap(){
        self.view.backgroundColor = .clear
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func english(_ sender: UIButton) {
        if MOLHLanguage.currentAppleLanguage() != "en" {
            MOLH.setLanguageTo("en")
            DispatchQueue.main.async {
                APIClient.changeLanguage(lang:MOLHLanguage.currentAppleLanguage()) { (Result, Status) in
                    switch Result {
                    case .success(let response):
                        print(response)
                        MOLH.reset()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    @IBAction func german(_ sender: UIButton) {
        if MOLHLanguage.currentAppleLanguage() != "de" {
            MOLH.setLanguageTo("de")
            DispatchQueue.main.async {
                APIClient.changeLanguage(lang:MOLHLanguage.currentAppleLanguage()) { (Result, Status) in
                    switch Result {
                    case .success(let response):
                        print(response)
                        MOLH.reset()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    @IBAction func arabic(_ sender: UIButton) {
        if MOLHLanguage.currentAppleLanguage() != "ar" {
            MOLH.setLanguageTo("ar")
            DispatchQueue.main.async {[weak self] in
                APIClient.changeLanguage(lang:MOLHLanguage.currentAppleLanguage()) { (Result, Status) in
                    switch Result {
                    case .success(let response):
                        print(response)
                        MOLH.reset()
                    case .failure(let error):
                        print(error.localizedDescription)
                        Alert.show("", massege: "Failed".localized, context: self!)
                    }
                }
            }
        }
    }
}
