//
//  HandlersForWithEmailViewController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 25/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension WithEmailViewController {
    
    @objc func handleDismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func handleVerification() {
        
        guard let email = emailTextfield.text,  let dateOfBirth = dateOfBirthTextfield.text else { return }
        
        if email.isEmpty {
            let alert = showAlert(withTitle: "입력오류", withMessage: "이메일을 입력해 주세요.", withActionTitle: "확인")
            present(alert, animated: true, completion: nil)
        } else if dateOfBirth.isEmpty {
            let alert = showAlert(withTitle: "입력오류", withMessage: "생년월일을 입력해 주세요.", withActionTitle: "확인")
            present(alert, animated: true, completion: nil)
        } else {
            
            sendVerification(withEmail: email, withDOB: dateOfBirth)
        }
        
        
       
    }
    
    func sendVerification(withEmail email: String, withDOB DOB: String)  {
        
        APIService.instance.findUsernameWithEmail(withEmail: email, withDOB: DOB) { (result, usernameReceived) in

            if result == "true" {
                self.username = usernameReceived
                self.addGradientColour(withButton: self.verificationButton)
                let alert = UIAlertController(title: "전송성공", message: "인증번호가 \(email)로 보내졌습니다.", preferredStyle: .alert)
                
                
                let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
                    
                    self.generateRandomNumberAndSend()
                    
                    let putVerificationNumberViewController = VerifyForUsername()
                    putVerificationNumberViewController.randomNumber = self.randomNumber
                    self.navigationController?.present(putVerificationNumberViewController, animated: true, completion: nil)
                })
                
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = showAlert(withTitle: "입력오류", withMessage: "입력하신 정보가 올바르지 않습니다.", withActionTitle: "확인")
                self.present(alert, animated: true, completion: nil)
            }
            
        }
    }

    //4자리 난수를 생성하고 서버에 이메일 주소와 난수를 보내주는 함수
    func generateRandomNumberAndSend() {
        randomNumber = generateRandomDigits(4)
        print("randomNumber", randomNumber)
        guard let email = emailTextfield.text else {
            return
        }
        
        APIService.instance.sendEmailVerficationNumber(withEmail: email, withRandomNumber: randomNumber!) { (result) in

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

















