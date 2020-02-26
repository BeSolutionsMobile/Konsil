//
//  PayPalViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 2/6/20.
//  Copyright © 2020 begroup. All rights reserved.
//

import UIKit

class PayPalViewController: UIViewController , PayPalPaymentDelegate {
    
    @IBOutlet weak var paymentAmount: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var animationView: UIView!{
        didSet{
            self.animationView.layer.cornerRadius = 10
            self.animationView.clipsToBounds = true
        }
    }
    
    
    var paypalConfig = PayPalConfiguration()
    var environment: String = PayPalEnvironmentSandbox {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    var acceptCreditCards: Bool = true {
        didSet{
            paypalConfig.acceptCreditCards = acceptCreditCards
        }
    }
    var type: Int?
    var doctor = ""
    var price = ""
    var id: Int?
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = nil
        rightBackBut()
        setUpPayPal()
    }
    
    func setUpPayPal(){
        paymentAmount.text = price + " $"
        paypalConfig.acceptCreditCards = acceptCreditCards
        paypalConfig.merchantName = "Konsil_med"
        paypalConfig.merchantPrivacyPolicyURL = URL(string: "www.google.com")
        paypalConfig.merchantUserAgreementURL = URL(string: "www.google.com")
        paypalConfig.languageOrLocale = NSLocale.preferredLanguages[0]
        paypalConfig.payPalShippingAddressOption = .payPal
        
        PayPalMobile.preconnect(withEnvironment: environment)
    }
    
    @IBAction func payWithPayPal(_ sender: UIButton) {
        if id != nil {
            let item = PayPalItem(name: doctor, withQuantity: 1, withPrice: NSDecimalNumber(string: price), withCurrency: "USD", withSku: "doctor")
            let items = [item]
            let subtotle = PayPalItem.totalPrice(forItems: items)
            let total = subtotle.decimalValue
            let payment = PayPalPayment(amount: NSDecimalNumber(decimal: total), currencyCode: "USD", shortDescription: "Consultation Payent", intent: .sale)
            payment.items = items
            
            if payment.processable {
                let paymentVC = PayPalPaymentViewController(payment: payment , configuration: paypalConfig , delegate: self)
                paymentVC?.modalPresentationStyle = .fullScreen
                present(paymentVC!, animated: true, completion: nil)
            } else {
                print("Cannot process payment")
            }
        }else {
            print("id is empty")
        }
    }
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print(completedPayment.confirmation)
        //        let profe = completedPayment.confirmation["response"]
        
        paymentViewController.dismiss(animated: true, completion: nil)
        
        if let id = id {
            DispatchQueue.main.async { [weak self] in
                if self?.type == 1 {
                    APIClient.comfirmConsultation(consultation_id: id, payment_status: 1) { (Result, Status) in
                        switch Result {
                        case .success(let response):
                            print(response)
                            if response.stats == 200 {
                                self?.id = nil
                                self?.showSuccess()
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                } else if self?.type == 2 {
                    APIClient.comfirmConversation(consultation_id: id, payment_status: 1) { (Result, status) in
                        switch Result {
                        case .success(let response):
                            print(response)
                            if response.stats == 200 {
                                self?.id = nil
                                self?.showSuccess()
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            
        }
    }
    func showSuccess(){
        backView.isHidden = false
        backView.isUserInteractionEnabled = true
        BlurView(view: animationView)
    }
    
    func BlurView(view: UIView){
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = view.bounds
        view.addSubview(blurView)
        view.isHidden = false
        let animation = Shared.showLottie(view: blurView.contentView, fileName: "success", contentMode: .scaleAspectFit)
        blurView.contentView.addSubview(animation)
        view.addSubview(blurView)
        animation.play { (finished) in
            if finished == true {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Main") as! MainViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
