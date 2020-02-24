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
    @IBOutlet weak var degreesCollectionView: UICollectionView!
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
    @IBOutlet weak var filterRate: CosmosView!
    @IBOutlet weak var submitButton: UIButton!{
        didSet{
            self.submitButton.layer.cornerRadius = self.submitButton.frame.height/2
        }
    }
    @IBOutlet weak var filterBackView: UIView!
    
    var delegate: FilterDoctorsDelegate?
    var degrees: [Degree]?
    var selectedDegrees: [Int]?
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
        let degree = selectedDegrees
        delegate?.updateData(degree: degree ?? [], rate: rate)
        self.view.backgroundColor = .clear
        self.dismiss(animated: false, completion: nil)
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
    
}

extension FilterViewController: UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout, SelectDegreeDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return degrees?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DegreeCell", for: indexPath) as! DegreesCollectionViewCell
        if let degree = degrees?[indexPath.row] {
            cell.degreeTitle.text = degree.degree
            cell.id = degree.id
            cell.delegate = self
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 22)
    }
    
    func toggleCheck(id: Int, checkBox: BEMCheckBox, status: Bool) {
        if status == true {
            if selectedDegrees?.append(id) == nil {
                selectedDegrees = [id]
            }
        } else {
            selectedDegrees?.removeAll {$0 == id }
        }
    }
    
}
