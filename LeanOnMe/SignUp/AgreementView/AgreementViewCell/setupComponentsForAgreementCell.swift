//
//  setupComponentsForAgreementCell.swift
//  LeanOnMe
//
//  Created by Justin Ji on 27/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension AgreementViewCell {
    
    func setupComponents() {
        
        addSubview(agreementTextview)
        addSubview(paragraphOne)
        addSubview(cautionLabel)
        addSubview(checkBoxOne)
        addSubview(agreementOne)
        addSubview(borderOne)
        addSubview(paragraphTwo)
        
        addSubview(checkBoxTwo)
        addSubview(agreementTwo)
        addSubview(borderTwo)
        
        addSubview(paragraphThree)
        addSubview(checkBoxThree)
        addSubview(agreementThree)
        addSubview(borderThree)
        addSubview(paragraphFour)
        addSubview(completeButton)
        
        
        
        NSLayoutConstraint.activate([
            
            
            
            
            agreementTextview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            agreementTextview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            agreementTextview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            agreementTextview.heightAnchor.constraint(equalToConstant: 330),
            
            paragraphOne.centerXAnchor.constraint(equalTo: agreementTextview.centerXAnchor),
            paragraphOne.topAnchor.constraint(equalTo: agreementTextview.topAnchor, constant: 20),
            paragraphOne.leadingAnchor.constraint(equalTo: agreementTextview.leadingAnchor, constant: 20),
            paragraphOne.trailingAnchor.constraint(equalTo: agreementTextview.trailingAnchor, constant: -10),
            paragraphOne.bottomAnchor.constraint(equalTo: agreementTextview.bottomAnchor, constant: -20),
            
            cautionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cautionLabel.topAnchor.constraint(equalTo: agreementTextview.bottomAnchor, constant: 10),
            cautionLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            cautionLabel.heightAnchor.constraint(equalToConstant: 20),
            
            checkBoxOne.topAnchor.constraint(equalTo: cautionLabel.bottomAnchor, constant: 30),
            checkBoxOne.leadingAnchor.constraint(equalTo: agreementTextview.leadingAnchor),
            checkBoxOne.widthAnchor.constraint(equalToConstant: 20),
            checkBoxOne.heightAnchor.constraint(equalToConstant: 20),
            
            agreementOne.topAnchor.constraint(equalTo: checkBoxOne.topAnchor),
            agreementOne.leadingAnchor.constraint(equalTo: checkBoxOne.trailingAnchor, constant: 10),
            agreementOne.widthAnchor.constraint(equalToConstant: 200),
            agreementOne.heightAnchor.constraint(equalToConstant: 20),
            
            borderOne.topAnchor.constraint(equalTo: checkBoxOne.bottomAnchor, constant: 10),
            borderOne.leadingAnchor.constraint(equalTo: agreementTextview.leadingAnchor),
            borderOne.trailingAnchor.constraint(equalTo: agreementTextview.trailingAnchor),
            borderOne.heightAnchor.constraint(equalToConstant: 1),
            
            paragraphTwo.topAnchor.constraint(equalTo: borderOne.bottomAnchor, constant: 3),
            paragraphTwo.leadingAnchor.constraint(equalTo: agreementTextview.leadingAnchor),
            paragraphTwo.trailingAnchor.constraint(equalTo: agreementTextview.trailingAnchor),
            paragraphTwo.heightAnchor.constraint(equalToConstant: 80),
            
            checkBoxTwo.topAnchor.constraint(equalTo: paragraphTwo.bottomAnchor, constant: 30),
            checkBoxTwo.leadingAnchor.constraint(equalTo: agreementTextview.leadingAnchor),
            checkBoxTwo.widthAnchor.constraint(equalToConstant: 20),
            checkBoxTwo.heightAnchor.constraint(equalToConstant: 20),
            
            agreementTwo.topAnchor.constraint(equalTo: checkBoxTwo.topAnchor),
            agreementTwo.leadingAnchor.constraint(equalTo: checkBoxTwo.trailingAnchor, constant: 10),
            agreementTwo.widthAnchor.constraint(equalToConstant: 200),
            agreementTwo.heightAnchor.constraint(equalToConstant: 20),
            
            borderTwo.topAnchor.constraint(equalTo: checkBoxTwo.bottomAnchor, constant: 10),
            borderTwo.leadingAnchor.constraint(equalTo: agreementTextview.leadingAnchor),
            borderTwo.trailingAnchor.constraint(equalTo: agreementTextview.trailingAnchor),
            borderTwo.heightAnchor.constraint(equalToConstant: 1),
            
            paragraphThree.topAnchor.constraint(equalTo: borderTwo.bottomAnchor, constant: 3),
            paragraphThree.leadingAnchor.constraint(equalTo: agreementTextview.leadingAnchor),
            paragraphThree.trailingAnchor.constraint(equalTo: agreementTextview.trailingAnchor),
            paragraphThree.heightAnchor.constraint(equalToConstant: 50),
            
            checkBoxThree.topAnchor.constraint(equalTo: paragraphThree.bottomAnchor, constant: 20),
            checkBoxThree.leadingAnchor.constraint(equalTo: agreementTextview.leadingAnchor),
            checkBoxThree.widthAnchor.constraint(equalToConstant: 20),
            checkBoxThree.heightAnchor.constraint(equalToConstant: 20),
            
            agreementThree.topAnchor.constraint(equalTo: checkBoxThree.topAnchor),
            agreementThree.leadingAnchor.constraint(equalTo: checkBoxThree.trailingAnchor, constant: 10),
            agreementThree.widthAnchor.constraint(equalToConstant: 200),
            agreementThree.heightAnchor.constraint(equalToConstant: 20),
            
            borderThree.topAnchor.constraint(equalTo: checkBoxThree.bottomAnchor, constant: 10),
            borderThree.leadingAnchor.constraint(equalTo: agreementTextview.leadingAnchor),
            borderThree.trailingAnchor.constraint(equalTo: agreementTextview.trailingAnchor),
            borderThree.heightAnchor.constraint(equalToConstant: 1),
            
            paragraphFour.topAnchor.constraint(equalTo: borderThree.bottomAnchor, constant: 3),
            paragraphFour.leadingAnchor.constraint(equalTo: agreementTextview.leadingAnchor),
            paragraphFour.trailingAnchor.constraint(equalTo: agreementTextview.trailingAnchor),
            paragraphFour.heightAnchor.constraint(equalToConstant: 40),
            
            completeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            completeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            completeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            completeButton.heightAnchor.constraint(equalToConstant: 50),
            ])
    }
    
}
