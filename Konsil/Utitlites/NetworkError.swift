//
//  NetworkError.swift
//  Konsil
//
//  Created by Ali Mohamed on 3/19/20.
//  Copyright © 2020 begroup. All rights reserved.
//

import Foundation
import UIKit

class NetworkError {
    static func createErrorView(view: UIView ,message: String){
        let errorView = UIView(frame: view.bounds)
        view.addSubview(errorView)
        errorView.backgroundColor = UIColor.white
        let imageView = UIImageView(image: UIImage(named: "ConnectionError"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        errorView.addSubview(imageView)
        NSLayoutConstraint.activate([imageView.heightAnchor.constraint(equalToConstant: view.frame.width * 2/3) , imageView.widthAnchor.constraint(equalToConstant: view.frame.width * 2/3) , imageView.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 1) , imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -70)])
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        errorView.addSubview(label)
        label.text = message
        label.numberOfLines = 0
        NSLayoutConstraint.activate([label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20) ,label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20), label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20), label.heightAnchor.constraint(equalToConstant: 30)])
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        
    }
}
