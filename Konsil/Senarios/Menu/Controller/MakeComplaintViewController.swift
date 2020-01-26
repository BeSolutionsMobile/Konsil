//
//  MakeComplaintViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/15/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import SideMenu

class MakeComplaintViewController: UIViewController , UITextViewDelegate {
    
    @IBOutlet weak var selectTybeTF: UITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.selectTybeTF, borderColor: UIColor.gray.cgColor , radius: 7)
            self.selectTybeTF.clipsToBounds = true
        }
    }
    @IBOutlet weak var complaintMessageTV: UITextView!{
        didSet{
            complaintMessageTV.layer.cornerRadius = 7
            complaintMessageTV.layer.borderColor = UIColor.gray.cgColor
            complaintMessageTV.layer.borderWidth = 1.5
            complaintMessageTV.delegate = self
        }
    }
    @IBOutlet weak var submitBut: UIButton!{
        didSet{
            submitBut.layer.cornerRadius = submitBut.frame.height/2
        }
    }
    
    let complaintTypes = ["Disruptive behavior" , "Prescriping Wrong Medicine" , "Wrong Diagonise" , "No Response From Doctor" ]
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
        openPickerView()
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        if #available(iOS 13.0, *) {
            let vc = storyboard?.instantiateViewController(identifier: "ComplaintDetails") as! ComplaintDetailsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        complaintMessageTV.text = ""
    }
    
    func openPickerView(){
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        selectTybeTF.inputView = pickerView
    }
    
    @objc func donePressed(){
        
        
    }
    
}

extension MakeComplaintViewController: UIPickerViewDataSource , UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return complaintTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectTybeTF.text = complaintTypes[row]
        self.view.endEditing(true)
    }
}
