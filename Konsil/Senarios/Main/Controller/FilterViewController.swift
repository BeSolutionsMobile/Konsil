//
//  FilterViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/16/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import BEMCheckBox
import Cosmos
protocol FilterDoctorsDelegate {
    func updateData(degree: [Int] ,rate: Int)
}
class FilterViewController: UIViewController {
    @IBOutlet weak var filterBackGround: UIImageView!{
        didSet{
            Rounded.roundedImage(imageView: self.filterBackGround, radius: 15, borderColor: UIColor.gray.cgColor, borderWidth: 2)
        }
    }
    @IBOutlet weak var logoBackGround: UIImageView!{
        didSet{
            Rounded.roundedImage(imageView: self.logoBackGround, radius: self.logoBackGround.frame.width/2, borderColor: UIColor.gray.cgColor, borderWidth: 2)
        }
    }
    @IBOutlet var filterOptions: [BEMCheckBox]!{
        didSet{
            checkStyle(BECheckBoxItmeArray: self.filterOptions)
        }
    }
    @IBOutlet weak var filterRate: CosmosView!
    @IBOutlet weak var submitButton: UIButton!{
        didSet{
            self.submitButton.layer.cornerRadius = self.submitButton.frame.height/2
        }
    }
    @IBOutlet weak var filterBackView: UIView!
    
    var delegate: FilterDoctorsDelegate?

    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapRecognizer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4006849315)
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        let rate = Int(filterRate.rating)
        let degree = getSelectedDegree()
        delegate?.updateData(degree: degree, rate: rate)
        self.view.backgroundColor = .clear
        self.dismiss(animated: false, completion: nil)
    }
    
    func checkStyle(BECheckBoxItmeArray: [BEMCheckBox]){
        for i in BECheckBoxItmeArray.indices{
            BECheckBoxItmeArray[i].onAnimationType = .bounce
            BECheckBoxItmeArray[i].offAnimationType = .bounce
        }
    }
    
    func addTapRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissOnTap))
        let viewGestureRecognizer = UITapGestureRecognizer(target: self, action: nil)
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
        filterBackView.addGestureRecognizer(viewGestureRecognizer)
    }
    
    @objc func dismissOnTap(){
        self.view.backgroundColor = .clear
        self.dismiss(animated: false, completion: nil)
    }
    
    func getSelectedDegree() -> [Int] {
        var degree: [Int]?
        for i in filterOptions.indices {
            if filterOptions[i].on == true {
                if degree?.append(i+1) == nil {
                    degree = [i+1]
                }
            }
        }
        return degree ?? []
    }
}
