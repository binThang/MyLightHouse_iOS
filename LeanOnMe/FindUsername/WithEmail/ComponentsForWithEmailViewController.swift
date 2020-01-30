//
//  ComponentsForWithEmailViewController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 25/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension WithEmailViewController {
    
    func setupComponents() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(dateOfBirthLabel)
        view.addSubview(dateOfBirthTextfield)
        view.addSubview(dateOfBirthBottomLine)
        view.addSubview(emailTitleLabel)
        view.addSubview(emailTextfield)
        view.addSubview(emailBottomLine)
        view.addSubview(verificationButton)
        view.addSubview(usernameBackgroundView)
        view.addSubview(labelOne)
        view.addSubview(resultView)
        view.addSubview(usernameLabelReceived)
        view.addSubview(labelTwo)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 71),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.heightAnchor.constraint(equalToConstant: 12),
            
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 9),
            subtitleLabel.widthAnchor.constraint(equalToConstant: 250),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 15),
            
            dateOfBirthLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 63),
            dateOfBirthLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            dateOfBirthLabel.widthAnchor.constraint(equalToConstant: 50),
            dateOfBirthLabel.heightAnchor.constraint(equalToConstant: 15),
            
            dateOfBirthTextfield.topAnchor.constraint(equalTo: dateOfBirthLabel.bottomAnchor, constant: 9),
            dateOfBirthTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 54),
            dateOfBirthTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -54),
            dateOfBirthTextfield.heightAnchor.constraint(equalToConstant: 30),
            
            dateOfBirthBottomLine.topAnchor.constraint(equalTo: dateOfBirthTextfield.bottomAnchor),
            dateOfBirthBottomLine.leadingAnchor.constraint(equalTo: dateOfBirthTextfield.leadingAnchor),
            dateOfBirthBottomLine.trailingAnchor.constraint(equalTo: dateOfBirthTextfield.trailingAnchor),
            dateOfBirthBottomLine.heightAnchor.constraint(equalToConstant: 1),
            
            emailTitleLabel.topAnchor.constraint(equalTo: dateOfBirthBottomLine.bottomAnchor, constant: 33),
            emailTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            emailTitleLabel.widthAnchor.constraint(equalToConstant: 60),
            emailTitleLabel.heightAnchor.constraint(equalToConstant: 15),
            
            emailTextfield.topAnchor.constraint(equalTo: emailTitleLabel.bottomAnchor, constant: 9),
            emailTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 54),
            emailTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -54),
            emailTextfield.heightAnchor.constraint(equalToConstant: 30),
            
            emailBottomLine.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor),
            emailBottomLine.leadingAnchor.constraint(equalTo: emailTextfield.leadingAnchor),
            emailBottomLine.trailingAnchor.constraint(equalTo: emailTextfield.trailingAnchor),
            emailBottomLine.heightAnchor.constraint(equalToConstant: 1),
            
            verificationButton.topAnchor.constraint(equalTo: emailBottomLine.bottomAnchor, constant: 16),
            verificationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -43),
            verificationButton.widthAnchor.constraint(equalToConstant: 79),
            verificationButton.heightAnchor.constraint(equalToConstant: 31),
            
            usernameBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -33),
            usernameBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameBackgroundView.widthAnchor.constraint(equalToConstant: 286),
            usernameBackgroundView.heightAnchor.constraint(equalToConstant: 83),
            
            labelOne.centerXAnchor.constraint(equalTo: usernameBackgroundView.centerXAnchor),
            labelOne.topAnchor.constraint(equalTo: usernameBackgroundView.topAnchor, constant: 20),
            labelOne.widthAnchor.constraint(equalToConstant: 100),
            labelOne.heightAnchor.constraint(equalToConstant: 20),
            
            resultView.topAnchor.constraint(equalTo: labelOne.bottomAnchor, constant: 5),
            resultView.centerXAnchor.constraint(equalTo: labelOne.centerXAnchor),
            resultView.widthAnchor.constraint(equalToConstant: measuredWidth),
            resultView.heightAnchor.constraint(equalToConstant: 20),
            
            labelTwo.centerYAnchor.constraint(equalTo: resultView.centerYAnchor),
            labelTwo.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -10),
            labelTwo.widthAnchor.constraint(equalToConstant: 45),
            labelTwo.heightAnchor.constraint(equalToConstant: 20),

            usernameLabelReceived.bottomAnchor.constraint(equalTo: labelTwo.bottomAnchor),
            usernameLabelReceived.trailingAnchor.constraint(equalTo: labelTwo.leadingAnchor, constant: -5),
            usernameLabelReceived.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 10),
            usernameLabelReceived.heightAnchor.constraint(equalToConstant: 20),

            ])
        
        labelOne.isHidden = true
        usernameLabelReceived.isHidden = true
        labelTwo.isHidden = true
    }
}