//
//  StripeViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 4/14/20.
//  Copyright © 2020 begroup. All rights reserved.
//

import UIKit
import Stripe
import NVActivityIndicatorView

class StripeViewController: UIViewController {
    
    var paymentIntentClientSecret: String?
    var amount: Double?
    var type: Int?
    var id: Int?
    lazy var cardTextField: STPPaymentCardTextField = {
        let cardTextField = STPPaymentCardTextField()
        return cardTextField
    }()
    lazy var payButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(red: 0.020, green: 0.455, blue: 0.576, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.setTitle("Pay".localized, for: .normal)
        button.addTarget(self, action: #selector(pay), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui()
        startCheckout()
    }
    
    
    func ui() {
        let stackView = UIStackView(arrangedSubviews: [cardTextField, payButton])
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: 2),
            view.rightAnchor.constraint(equalToSystemSpacingAfter: stackView.rightAnchor, multiplier: 2),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc
    func pay() {
        guard let paymentIntentClientSecret = paymentIntentClientSecret else {
            return;
        }
        // Collect card details
        let cardParams = cardTextField.cardParams
        let paymentMethodParams = STPPaymentMethodParams(card: cardParams, billingDetails: nil, metadata: nil)
        let paymentIntentParams = STPPaymentIntentParams(clientSecret: paymentIntentClientSecret)
        paymentIntentParams.paymentMethodParams = paymentMethodParams
        
        // Submit the payment
        let paymentHandler = STPPaymentHandler.shared()
        paymentHandler.confirmPayment(withParams: paymentIntentParams, authenticationContext: self) {[weak self] (status, paymentIntent, error) in
            switch (status) {
            case .failed:
                print(error?.localizedDescription ?? "")
                Alert.show("Payment failed".localized, massege: error?.localizedDescription ?? "Payment Failed Please Try Again".localized , context: self!)
                break
                
            case .canceled:
                Alert.show("Payment canceled".localized, massege: "Payment process was canceled".localized , context: self!)
                print(error?.localizedDescription ?? "" )
                break
                
            case .succeeded:
                print(paymentIntent?.description ?? "")
                Alert.showWithAction("Payment succeeded".localized , massege: "Payment process completed successfully".localized , context: self!) {[weak self] (action) in
                    self?.finishOrder()
                }
                break
                
            @unknown default:
                fatalError()
                break
            }
        }
    }
    
    
    func startCheckout() {
        if let amount = amount {
            DispatchQueue.global().async { [weak self] in
                APIClient.getStripeToken(amount: amount) { (result, status) in
                    switch result  {
                    case .success(let response):
                        print(response)
                        self?.paymentIntentClientSecret = response.client_secret
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func finishOrder(){
        if let id = id {
            self.startAnimating()
            DispatchQueue.main.async { [weak self] in
                if self?.type == 1 {
                    APIClient.comfirmConsultation(consultation_id: id, payment_status: 1) { (Result, Status) in
                        switch Result {
                        case .success(let response):
                            print(response)
                            if response.stats == 200 {
                                self?.id = nil
                                if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "Main") as? MainViewController {
                                    self?.navigationController?.pushViewController(vc, animated: true)
                                }
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                            Alert.show("Error".localized, massege: "Please check your network connection and try again".localized, context: self!)
                        }
                        self?.stopAnimating()
                    }
                } else if self?.type == 2 {
                    APIClient.comfirmConversation(consultation_id: id, payment_status: 1) { (Result, status) in
                        switch Result {
                        case .success(let response):
                            print(response)
                            if response.stats == 200 {
                                self?.id = nil
                                if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "Main") as? MainViewController {
                                    self?.navigationController?.pushViewController(vc, animated: true)
                                }                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                            Alert.show("Error".localized, massege: "Please check your network connection and try again".localized, context: self!)
                        }
                        self?.stopAnimating()
                    }
                }
            }
            
        }
    }
}


extension StripeViewController: STPAuthenticationContext {
    func authenticationPresentingViewController() -> UIViewController {
        return self
    }
}
