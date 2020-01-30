//
//  HandlersForFindPasswordWithEmail.swift
//  LeanOnMe
//
//  Created by Justin Ji on 26/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension FindPasswordWithEmailViewController {
    @objc func handleDismissKeyboard() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame.origin.y = 0
        }, completion: nil)
        view.endEditing(true)
    }
    
    //문자 메세지 인증번호 보내는 함수
    @objc func handleVerification() {
        
        guard let username = usernameTextfield.text, let email = emailTextfield.text, let dateOfBirth = dateOfBirthTextfield.text else {
            return
        }
        
        APIService.instance.findPasswordWithEmail(withUsername: username, withEmail: email, withDOB: dateOfBirth) { (result) in
            if result == "true" {
                self.addGradientColour(withButton: self.verificationButton)

                let alert = UIAlertController(title: "전송성공", message: "인증번호가 보내졌습니다.", preferredStyle: .alert)
                
                self.verificationButton.setTitleColor(.white, for: .normal)
                
                let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
                    self.generateRandomNumberAndSend()
                    
                    let verifyForPassword = VerifyForPassword()
                    verifyForPassword.randomNumber = self.randomNumber
                    self.navigationController?.pushViewController(verifyForPassword, animated: true)
                })
                
                alert.addAction(action)
                self.present(alert, animated: true, completion: {
                    
                })
                
            } else {
                let alert = UIAlertController(title: "입력오류", message: "입력하신 정보가 올바르지 않습니다.", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default, handler: nil)
                
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
     
    }
    
    func generateRandomNumberAndSend() {
        randomNumber = generateRandomDigits(4)
        guard let email = emailTextfield.text else { return }
        
        APIService.instance.sendEmailVerficationNumber(withEmail: email, withRandomNumber: randomNumber!) { (result) in
            
        }
    }
    
    //휴대폰 번호 텍스트필드를 눌렀을때 전체뷰를 위로 올려 유저가 볼수 있도록 해준다.
    @objc func handleTextfield() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame.origin.y = -100
        }, completion: nil)
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

























