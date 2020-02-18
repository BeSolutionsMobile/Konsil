//
//  MakeComplaintViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/15/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import SideMenu

class MakeComplaintViewController: UIViewController {
    
    @IBOutlet weak var selectTybeTF: UITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.selectTybeTF, borderColor: UIColor.gray.cgColor , radius: 7)
            self.selectTybeTF.clipsToBounds = true
        }
    }
    @IBOutlet weak var complaintMessageTV: UITextView!{
        didSet{
            Rounded.roundedCornerTextView(textView: complaintMessageTV, borderColor: UIColor.gray.cgColor, radius: 7, borderWidth: 1.5)
            complaintMessageTV.delegate = self
            complaintMessageTV.text = "Enter Complaint Details Here".localized
        }
    }
    @IBOutlet weak var submitBut: UIButton!{
        didSet{
            submitBut.layer.cornerRadius = submitBut.frame.height/2
        }
    }
    
    var complaints: [Complaint]?
    var selectedComplaintID: Int?
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
        openPickerView()
        getComplaintTypes()
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        makeComplaint()
    }
    
    func openPickerView(){
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        selectTybeTF.inputView = pickerView
    }
    
    func getComplaintTypes() {
        DispatchQueue.global().async { [weak self] in
            APIClient.getComplaintTypes { (Result, Status) in
                switch Result {
                case .success(let response):
                    print(response)
                    if Status == 200 {
                        self?.complaints = response.data
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func makeComplaint(){
        if selectedComplaintID != nil {
            DispatchQueue.main.async { [weak self] in
                APIClient.makeComplaint(type_id: self?.selectedComplaintID ?? 0, complaint: self?.complaintMessageTV.text ?? "") { (Result, Status) in
                    switch Result {
                    case .success(let response):
                        print(response)
                        if Status == 200 {
                            let vc = self!.storyboard?.instantiateViewController(withIdentifier: "ComplaintDetails") as! ComplaintDetailsViewController
                            self?.navigationController?.pushViewController(vc, animated: true)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        Alert.show("Failed".localized, massege: "Please Try Again".localized, context: self!)
                    }
                    print(Status)
                }
            }
        } else {
            Alert.show("Error".localized, massege: "All Fields Are Required".localized, context: self )
        }
    }
    
}

extension MakeComplaintViewController: UIPickerViewDataSource , UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return complaints?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return complaints?[row].title ?? ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectTybeTF.text = complaints?[row].title
        selectedComplaintID = complaints?[row].id
        self.view.endEditing(true)
    }
}
