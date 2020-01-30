//
//  HandlersForWithPhoneNumberViewController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 25/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension WithPhoneNumberViewController {
    
    @objc func handleDismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func handleVerification() {
        
        guard let phoneNumber = phoneNumberTextfield.text,  let dateOfBirth = dateOfBirthTextfield.text else { return }

        if phoneNumber.isEmpty {
            let alert = showAlert(withTitle: "입력오류", withMessage: "전화번호를 입력해 주세요.", withActionTitle: "확인")
            present(alert, animated: true, completion: nil)
        } else if dateOfBirth.isEmpty {
            let alert = showAlert(withTitle: "입력오류", withMessage: "생년월일을 입력해 주세요.", withActionTitle: "확인")
            present(alert, animated: true, completion: nil)
        } else {
            
            sendVerification(withPhoneNumber: phoneNumber, withDOB: dateOfBirth)
        }
        
    }
    
    func sendVerification(withPhoneNumber phoneNumber: String, withDOB DOB: String) {
        
        APIService.instance.findUsernameWithPhoneNumber(withPhoneNumber: phoneNumber, withDOB: DOB) { (result, usernameReceived)  in
            
            self.username = usernameReceived
            if result == "true" {
                
                self.addGradientColour(withButton: self.verificationButton)
                let alert = UIAlertController(title: "전송성공", message: "인증번호가 보내졌습니다.", preferredStyle: .alert)
              
                let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
                    self.generateRandomNumber()
                    
                    let verifyForUsername = VerifyForUsername()
                    verifyForUsername.randomNumber = self.randomNumber
                    self.navigationController?.present(verifyForUsername, animated: true, completion: nil)
                })
                
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = showAlert(withTitle: "입력오류", withMessage: "입력하신 정보가 올바르지 않습니다.", withActionTitle: "확인")
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func generateRandomNumber() {
        randomNumber = generateRandomDigits(4)
        guard let phoneNumber = phoneNumberTextfield.text else {
            return
        }
        
        APIService.instance.phoneVerification(withPhoneNumber: phoneNumber, withRandomNumber: randomNumber!) { (result) in
           
        }
    }
    
    func addGradientColour(withButton button: UIButton) {
        
        button.layer.addSublayer(gradientView)
        button.layer.masksToBounds = false
        button.addSubview(verificationSuccess)
        button.layer.borderWidth = 0
        gradientView.frame = button.bounds
        verificationSuccess.frame = button.bounds
    }
    
    func removeGradientColour() {
        verificationButton.layer.borderWidth = 1
        gradientView.removeFromSuperlayer()
        verificationSuccess.removeFromSuperview()
    }
    
}
