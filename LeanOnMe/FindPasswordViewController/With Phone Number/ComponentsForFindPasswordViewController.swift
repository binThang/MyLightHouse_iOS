//
//  HandlersForFindPasswordViewController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 19/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension FindPasswordWithPhoneNumberViewController {
    func setupComponents() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(usernameLabel)
        view.addSubview(usernameTextfield)
        view.addSubview(usernameBottomLine)
        view.addSubview(dateOfBirthLabel)
        view.addSubview(dateOfBirthTextfield)
        view.addSubview(dateOfBirthBottomLine)
        view.addSubview(phoneNumberLabel)
        view.addSubview(phoneNumberTextfield)
        view.addSubview(phoneNumberBottomLine)
        view.addSubview(verificationButton)
        view.addSubview(verificationButton)
       
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 71),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.heightAnchor.constraint(equalToConstant: 12),
            
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 9),
            subtitleLabel.widthAnchor.constraint(equalToConstant: 250),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 15),
            
            usernameLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 63),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            usernameLabel.widthAnchor.constraint(equalToConstant: 50),
            usernameLabel.heightAnchor.constraint(equalToConstant: 12),
            
            usernameTextfield.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 9),
            usernameTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 54),
            usernameTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -54),
            usernameTextfield.heightAnchor.constraint(equalToConstant: 30),
            
            usernameBottomLine.topAnchor.constraint(equalTo: usernameTextfield.bottomAnchor),
            usernameBottomLine.leadingAnchor.constraint(equalTo: usernameTextfield.leadingAnchor),
            usernameBottomLine.trailingAnchor.constraint(equalTo: usernameTextfield.trailingAnchor),
            usernameBottomLine.heightAnchor.constraint(equalToConstant: 1),
            
            dateOfBirthLabel.topAnchor.constraint(equalTo: usernameBottomLine.bottomAnchor, constant: 33),
            dateOfBirthLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            dateOfBirthLabel.widthAnchor.constraint(equalToConstant: 50),
            dateOfBirthLabel.heightAnchor.constraint(equalToConstant: 13),
            
            dateOfBirthTextfield.topAnchor.constraint(equalTo: dateOfBirthLabel.bottomAnchor, constant: 9),
            dateOfBirthTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 54),
            dateOfBirthTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -54),
            dateOfBirthTextfield.heightAnchor.constraint(equalToConstant: 30),
            
            dateOfBirthBottomLine.topAnchor.constraint(equalTo: dateOfBirthTextfield.bottomAnchor),
            dateOfBirthBottomLine.leadingAnchor.constraint(equalTo: dateOfBirthTextfield.leadingAnchor),
            dateOfBirthBottomLine.trailingAnchor.constraint(equalTo: dateOfBirthTextfield.trailingAnchor),
            dateOfBirthBottomLine.heightAnchor.constraint(equalToConstant: 1),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: dateOfBirthBottomLine.bottomAnchor, constant: 33),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            phoneNumberLabel.widthAnchor.constraint(equalToConstant: 100),
            phoneNumberLabel.heightAnchor.constraint(equalToConstant: 15),
            
            phoneNumberTextfield.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 9),
            phoneNumberTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 54),
            phoneNumberTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -54),
            phoneNumberTextfield.heightAnchor.constraint(equalToConstant: 30),
            
            phoneNumberBottomLine.topAnchor.constraint(equalTo: phoneNumberTextfield.bottomAnchor),
            phoneNumberBottomLine.leadingAnchor.constraint(equalTo: phoneNumberTextfield.leadingAnchor),
            phoneNumberBottomLine.trailingAnchor.constraint(equalTo: phoneNumberTextfield.trailingAnchor),
            phoneNumberBottomLine.heightAnchor.constraint(equalToConstant: 1),
            
            verificationButton.topAnchor.constraint(equalTo: phoneNumberBottomLine.bottomAnchor, constant: 16),
            verificationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -43),
            verificationButton.widthAnchor.constraint(equalToConstant: 79),
            verificationButton.heightAnchor.constraint(equalToConstant: 31),
            
            ])
    }
    
   
}
