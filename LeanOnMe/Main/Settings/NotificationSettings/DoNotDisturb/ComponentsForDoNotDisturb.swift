//
//  ComponentsForDoNotDisturb.swift
//  LeanOnMe
//
//  Created by Justin Ji on 31/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension DoNotDisturbView {
    
    func setupComponents() {
        
        view.addSubview(clockImageView)
        view.addSubview(titleLabel)
        view.addSubview(border)
        
        view.addSubview(inBetweenView)
        view.addSubview(startingLabel)
        view.addSubview(endingLabel)
        view.addSubview(startingUp)
        view.addSubview(startingDown)
        view.addSubview(endingUp)
        view.addSubview(endingDown)
        view.addSubview(borderTwo)
        
        view.addSubview(completButton)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            clockImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            clockImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            clockImageView.widthAnchor.constraint(equalToConstant: 20),
            clockImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: clockImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: clockImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            border.topAnchor.constraint(equalTo: clockImageView.bottomAnchor, constant: 10),
            border.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            border.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            border.heightAnchor.constraint(equalToConstant: 1),
            
            inBetweenView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            inBetweenView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inBetweenView.widthAnchor.constraint(equalToConstant: 10),
            inBetweenView.heightAnchor.constraint(equalToConstant: 2),
            
            startingLabel.centerYAnchor.constraint(equalTo: inBetweenView.centerYAnchor),
            startingLabel.trailingAnchor.constraint(equalTo: inBetweenView.leadingAnchor, constant: -20),
            startingLabel.widthAnchor.constraint(equalToConstant: 50),
            startingLabel.heightAnchor.constraint(equalToConstant: 30),
            
            endingLabel.centerYAnchor.constraint(equalTo: inBetweenView.centerYAnchor),
            endingLabel.leadingAnchor.constraint(equalTo: inBetweenView.trailingAnchor, constant: 30),
            endingLabel.widthAnchor.constraint(equalToConstant: 50),
            endingLabel.heightAnchor.constraint(equalToConstant: 30),
            
            startingUp.bottomAnchor.constraint(equalTo: startingLabel.topAnchor, constant: -10),
            startingUp.centerXAnchor.constraint(equalTo: startingLabel.centerXAnchor),
            startingUp.widthAnchor.constraint(equalToConstant: 50),
            startingUp.heightAnchor.constraint(equalToConstant: 20),
            
            startingDown.topAnchor.constraint(equalTo: startingLabel.bottomAnchor, constant: 10),
            startingDown.centerXAnchor.constraint(equalTo: startingLabel.centerXAnchor),
            startingDown.widthAnchor.constraint(equalToConstant: 50),
            startingDown.heightAnchor.constraint(equalToConstant: 20),
            
            endingUp.bottomAnchor.constraint(equalTo: endingLabel.topAnchor, constant: -10),
            endingUp.centerXAnchor.constraint(equalTo: endingLabel.centerXAnchor),
            endingUp.widthAnchor.constraint(equalToConstant: 50),
            endingUp.heightAnchor.constraint(equalToConstant: 20),
            
            endingDown.topAnchor.constraint(equalTo: endingLabel.bottomAnchor, constant: 10),
            endingDown.centerXAnchor.constraint(equalTo: endingLabel.centerXAnchor),
            endingDown.widthAnchor.constraint(equalToConstant: 50),
            endingDown.heightAnchor.constraint(equalToConstant: 20),
            
            completButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
            completButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            completButton.widthAnchor.constraint(equalToConstant: 100),
            completButton.heightAnchor.constraint(equalToConstant: 20),
            
            borderTwo.bottomAnchor.constraint(equalTo: completButton.topAnchor, constant: -10),
            borderTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            borderTwo.widthAnchor.constraint(equalToConstant: view.frame.width),
            borderTwo.heightAnchor.constraint(equalToConstant: 1),
            ])
    }
}
