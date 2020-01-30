//
//  ComponentsForVerificationController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 25/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension VerificationController {
    
    func setupComponents() {
        view.addSubview(phoneNumberOrEmailTextfield)
        view.addSubview(sendVerficationNumberButton)
        view.addSubview(verficationNumberTextfield)
        view.addSubview(verfiyPhoneNumberButton)
        view.addSubview(switchToEmailVerification)
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            
            sendVerficationNumberButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            sendVerficationNumberButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            sendVerficationNumberButton.widthAnchor.constraint(equalToConstant: 74),
            sendVerficationNumberButton.heightAnchor.constraint(equalToConstant: 41),
            
            phoneNumberOrEmailTextfield.topAnchor.constraint(equalTo: sendVerficationNumberButton.topAnchor),
            phoneNumberOrEmailTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            phoneNumberOrEmailTextfield.trailingAnchor.constraint(equalTo: sendVerficationNumberButton.leadingAnchor, constant: 1),
            phoneNumberOrEmailTextfield.heightAnchor.constraint(equalToConstant: 41),
            
            verfiyPhoneNumberButton.topAnchor.constraint(equalTo: sendVerficationNumberButton.bottomAnchor, constant: 7),
            verfiyPhoneNumberButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            verfiyPhoneNumberButton.widthAnchor.constraint(equalToConstant: 74),
            verfiyPhoneNumberButton.heightAnchor.constraint(equalToConstant: 41),
            
            verficationNumberTextfield.topAnchor.constraint(equalTo: phoneNumberOrEmailTextfield.bottomAnchor, constant: 7),
            verficationNumberTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            verficationNumberTextfield.trailingAnchor.constraint(equalTo: verfiyPhoneNumberButton.leadingAnchor, constant: 1),
            verficationNumberTextfield.heightAnchor.constraint(equalToConstant: 41),
            
            switchToEmailVerification.topAnchor.constraint(equalTo: verficationNumberTextfield.bottomAnchor, constant: 15),
            switchToEmailVerification.leadingAnchor.constraint(equalTo: verficationNumberTextfield.leadingAnchor),
            switchToEmailVerification.widthAnchor.constraint(equalToConstant: 200),
            switchToEmailVerification.heightAnchor.constraint(equalToConstant: 12),
            
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
}
