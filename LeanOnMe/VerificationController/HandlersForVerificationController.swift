//
//  HandlersForVerificationController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 25/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension VerificationController {
    
    @objc func handleDismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func handlePhoneNumberOrEamilTextfield() {
        
      
            sendVerficationNumberButton.backgroundColor = .white
        sendVerficationNumberButton.setTitleColor(UIColor.lightGray.withAlphaComponent(0.8), for: .normal)
        
    }
    
    @objc func handleverficationNumberTextfield() {
        
        if isSwitchedToEmail {
            
        }
        
        verfiyPhoneNumberButton.backgroundColor = .white
    verfiyPhoneNumberButton.setTitleColor(UIColor.lightGray.withAlphaComponent(0.8), for: .normal)
    
    }
    
    @objc func handleNextButton() {
        if isVerified {
            let signUpController = SignUpViewController()
            self.navigationController?.pushViewController(signUpController, animated: true)
        } else {
            let alert = UIAlertController(title: "인증확인", message: "메세지 또는 이메일 인증을 해주세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlertForEmptyTextfield(title: String, isEmailChosen: Bool) {
        
        var titleStr: String?
        titleStr = isEmailChosen ? "\(title)을": "\(title)를"
        
        guard let titleDecided = titleStr else { return }
        let alert = UIAlertController(title: "입력오류", message: "\(titleDecided) 입력해주세요.", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
            
            self.phoneNumberOrEmailTextfield.becomeFirstResponder()
        })
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func handleSendVerficationNumber() {
        
        if phoneNumberOrEmailTextfield.text == "" {
            if isSwitchedToEmail {
                showAlertForEmptyTextfield(title: "이메일", isEmailChosen: true)
            } else {
                showAlertForEmptyTextfield(title: "휴대폰 번호", isEmailChosen: false)
            }
        }
        
        //true: 현재 이메일 인증, false: 현재 메세지 인증
        if isSwitchedToEmail {
            //이메일 형식확인 후 인증 번호를 보낸다.
            let isEmailValid = isValidEmailAddress(emailAddressString: phoneNumberOrEmailTextfield.text!)
            if isEmailValid == false {
                let alert = UIAlertController(title: "입력오류", message: "정확한 이메일 형식을 입력해 주세요.", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default, handler: { (_) in
                    self.phoneNumberOrEmailTextfield.becomeFirstResponder()
                })
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            } else {
                sendEmailVerificationNumber()
            }
        } else {
            sendVerificationNumberToPhone()
        }
    }
    
    func sendVerificationNumberToPhone() {
        
        let randomNumberGenerated = generateRandomDigits(4)
        randomNumber = randomNumberGenerated

        if phoneNumberOrEmailTextfield.text != "" {
            guard let phoneNumber = phoneNumberOrEmailTextfield.text else { return }
            
            
            APIService.instance.checkIfPhoneNumberIsAvailable(withPhoneNumber: phoneNumber, completionHandler: { (result) in
                
                if result == "true" {
                   
                    self.isVerificationSent = true
                    phoneNumberVerified = phoneNumber
                    emailAddressVerified = ""
                    
                    APIService.instance.phoneVerification(withPhoneNumber: phoneNumber, withRandomNumber: randomNumberGenerated, completionHandler: { (result) in
                        
                        self.isVerificationNumberSent = true
                        
                        let alert = UIAlertController(title: "전송성공", message: "인증번호가 보내졌습니다.", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
                            self.verficationNumberTextfield.becomeFirstResponder()
                            
                        })
                        
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                        self.sendVerficationNumberButton.backgroundColor = orangeColour
                        self.sendVerficationNumberButton.setTitleColor(.white, for: .normal)
                        
                    })
                } else {
                    let alert = UIAlertController(title: "휴대폰번호 중복", message: "입력하신 번호가 중복됩니다..", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
                        
                        self.phoneNumberOrEmailTextfield.becomeFirstResponder()
                    })
                    
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            })
            
        } else {
            let alert = UIAlertController(title: "입력오류", message: "인증할 휴대폰 번호 또는 이메일을 입력해 주세요.", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
                self.isVerificationNumberSent = false
                self.phoneNumberOrEmailTextfield.becomeFirstResponder()
            })
            
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func sendEmailVerificationNumber() {
        
        
        let randomNumberGenerated = generateRandomDigits(4)
        randomNumber = randomNumberGenerated
        
        print(randomNumberGenerated)
        if phoneNumberOrEmailTextfield.text != "" {
            guard let email = phoneNumberOrEmailTextfield.text else { return }
            
            APIService.instance.checkIfEmailIsAvailable(withEmail: email, completionHandler: { (result) in

                if result == "true" {
                
                    self.isVerificationSent = true
                    emailAddressVerified = email
                    phoneNumberVerified = ""
                    
                    APIService.instance.sendEmailVerficationNumber(withEmail: email, withRandomNumber: randomNumberGenerated, completionHandler: { (result) in
                        
                        let alert = UIAlertController(title: "전송성공", message: "인증번호가 \(email)로 보내졌습니다.", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
                            self.verficationNumberTextfield.becomeFirstResponder()
                        })
                        
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                        
                        self.sendVerficationNumberButton.backgroundColor = orangeColour
                        self.sendVerficationNumberButton.setTitleColor(.white, for: .normal)
                    })
                } else {
                    
                    self.isVerificationSent = false
                    let alert = UIAlertController(title: "이메일 중복", message: "입력하신 이메일이 중복됩니다.", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
                        
                        self.phoneNumberOrEmailTextfield.becomeFirstResponder()
                    })
                    
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    

    @objc func handleVerify() {
        
        if isVerificationSent {
            if randomNumber == verficationNumberTextfield.text {
                let alert = UIAlertController(title: "인증성공", message: "인증번호가 일치합니다.", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
                    let signUpController = SignUpViewController()
                    self.navigationController?.pushViewController(signUpController, animated: true)
                })
                
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                verfiyPhoneNumberButton.backgroundColor = orangeColour
                verfiyPhoneNumberButton.setTitleColor(.white, for: .normal)
                
            } else {
                let alert = UIAlertController(title: "인증실패", message: "인증번호가 일치하지 않습니다. 다시 입력해 주세요", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
                    
                })
                isVerified = false
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "인증실패", message: "먼저 인증을 번호를 받아주세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
                
            })
            isVerified = false
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func handleSwitch() {
        
        //true: 현재 이메일 인증, false: 현재 폰 메세지 인증
        if isSwitchedToEmail {
            phoneNumberOrEmailTextfield.placeholder = "휴대폰 번호를 입력해 주세요."
            phoneNumberOrEmailTextfield.text = ""
            switchToEmailVerification.text = "이메일로 인증하기"

        sendVerficationNumberButton.setTitleColor(UIColor.lightGray.withAlphaComponent(0.8), for: .normal)
            sendVerficationNumberButton.backgroundColor = .white
            
        verfiyPhoneNumberButton.setTitleColor(UIColor.lightGray.withAlphaComponent(0.8), for: .normal)
            verfiyPhoneNumberButton.backgroundColor = .white
            
            isSwitchedToEmail = false
        } else {
            phoneNumberOrEmailTextfield.placeholder = "이메일 주소를 입력해 주세요."
            phoneNumberOrEmailTextfield.text = ""
            switchToEmailVerification.text = "문자메세지로 인증하기"
        sendVerficationNumberButton.setTitleColor(UIColor.lightGray.withAlphaComponent(0.8), for: .normal)
            sendVerficationNumberButton.backgroundColor = .white
            
        verfiyPhoneNumberButton.setTitleColor(UIColor.lightGray.withAlphaComponent(0.8), for: .normal)
            verfiyPhoneNumberButton.backgroundColor = .white
            isSwitchedToEmail = true
        }
    }
}



















































