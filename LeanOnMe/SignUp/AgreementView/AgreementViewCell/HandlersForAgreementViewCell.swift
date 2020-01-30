//
//  HandlersForAgreementViewCell.swift
//  LeanOnMe
//
//  Created by Justin Ji on 27/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension AgreementViewCell {
    
    @objc func handleCheckBoxOne() {
        if isOneChecked {
            checkBoxOne.setBackgroundImage(nil, for: .normal)
            agreementOne.textColor = unselected_textColour
            isOneChecked = false
        } else {
            checkBoxOne.setBackgroundImage(#imageLiteral(resourceName: "check"), for: .normal)
            agreementOne.textColor = selected_textColour
            isOneChecked = true
        }
    }
    
    @objc func handleCheckBoxTwo() {
        if isTwoChecked {
            checkBoxTwo.setBackgroundImage(nil, for: .normal)
            agreementTwo.textColor = unselected_textColour
            isTwoChecked = false
        } else {
            checkBoxTwo.setBackgroundImage(#imageLiteral(resourceName: "check"), for: .normal)
            agreementTwo.textColor = selected_textColour
            isTwoChecked = true
        }
    }
    
    @objc func handleCheckBoxThree() {
        if isThreeChecked {
            checkBoxThree.setBackgroundImage(nil, for: .normal)
            agreementThree.textColor = unselected_textColour
            isThreeChecked = false
        } else {
            checkBoxThree.setBackgroundImage(#imageLiteral(resourceName: "check"), for: .normal)
            agreementThree.textColor = selected_textColour
            isThreeChecked = true
        }
    }
    
    @objc func handleCompleteButton() {
        if isOneChecked, isTwoChecked, isThreeChecked {
            
            NotificationCenter.default.post(name: Notification.Name("allAgreed"), object: self, userInfo: ["result": "good"])
        } else {
            NotificationCenter.default.post(name: Notification.Name("allAgreed"), object: self, userInfo: ["result": "noGood"])
        }
    }
}













































