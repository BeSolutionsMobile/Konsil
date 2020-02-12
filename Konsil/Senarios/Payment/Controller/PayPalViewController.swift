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
    var doctor = ""
    var price = ""
    //MARK:- ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            
        }
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print(completedPayment.confirmation)
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    
    
}
