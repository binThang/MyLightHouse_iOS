//
//  HandlersForSignUpViewCell.swift
//  LeanOnMe
//
//  Created by Justin Ji on 18/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension SignUpViewCell {
    
    @objc func handleUsernameTextfield() {
       
        verfiyUsernameButton.backgroundColor = UIColor.white
        verfiyUsernameButton.setTitleColor(UIColor.lightGray.withAlphaComponent(0.8), for: .normal)
        verfiyUsernameButton.layer.borderWidth = 1
    }
    
    @objc func handleNicknameTextfield() {
        
        verfiyNicknameButton.backgroundColor = UIColor.white
        verfiyNicknameButton.setTitleColor(UIColor.lightGray.withAlphaComponent(0.8), for: .normal)
        verfiyNicknameButton.layer.borderWidth = 1
    }
    
    
    
    @objc func handleCheckUsername() {
        
        guard usernameTextfield.text != nil, let username = usernameTextfield.text else { return }
        
        if (usernameTextfield.text?.count)! < Int(4) || (usernameTextfield.text?.count)! > Int(15)  {
            let alert = UIAlertController(title: "입력오류", message: "닉네임은 2자 이상 10자 이하로 정해주세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: { (_) in
                self.usernameTextfield.becomeFirstResponder()
            })
            
            alert.addAction(action)
            window?.rootViewController?.present(alert, animated: true, completion: nil)
        } else {
            APIService.instance.checkUsername(withUsername: username) { (result) in
                print(result)
                if result == "true" {
                    self.isUsernameChecked = true
                    let alert = UIAlertController(title: "아이디 사용가능", message: "사용할 수 있는 아이디 입니다.", preferredStyle: .alert)
                    
                    let action =  UIAlertAction(title: "확인", style: .default, handler: { (action) in
                        self.verfiyUsernameButton.setTitleColor(UIColor.init(hexString: "#FFFFFF"), for: .normal)
                        self.verfiyUsernameButton.titleLabel?.font = komaconFont(13)
                        self.verfiyUsernameButton.backgroundColor = UIColor.init(hexString: "#ffb445")
                        self.verfiyUsernameButton.layer.borderWidth = 1

                    })
                    
                    alert.addAction(action)
                    self.window?.rootViewController?.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "아이디 사용 불가능", message: "사용할 수 없는 아이디 입니다.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .default, handler: nil)
                    
                    alert.addAction(action)
                    self.window?.rootViewController?.present(alert, animated: true, completion: nil)
                }
            }
        }
       
    }
    
    @objc func handleCheckNickname() {

        guard nicknameTextfield.text != nil, let nickname = nicknameTextfield.text else { return }
        
        if (nicknameTextfield.text?.count)! < Int(2) || (nicknameTextfield.text?.count)! > Int(10)  {
            let alert = UIAlertController(title: "입력오류", message: "닉네임은 2자 이상 10자 이하로 정해주세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: { (_) in
                self.nicknameTextfield.becomeFirstResponder()
            })
            
            alert.addAction(action)
            window?.rootViewController?.present(alert, animated: true, completion: nil)
        } else {
            APIService.instance.checkNickname(withNickname: nickname) { (result) in
                if result == "true" {
                    self.isNicknameChecked = true
                    let alert = UIAlertController(title: "닉네임 사용가능", message: "사용할 수 있는 닉네임 입니다.", preferredStyle: .alert)
                    let action =  UIAlertAction(title: "확인", style: .default, handler: { (action) in
                        self.verfiyNicknameButton.backgroundColor = orangeColour
                        self.verfiyNicknameButton.setTitleColor(.white, for: .normal)
                        self.verfiyNicknameButton.layer.borderWidth = 0
                    })
                    
                    alert.addAction(action)
                    self.window?.rootViewController?.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "닉네임 사용 불가능", message: "사용할 수 없는 닉네임 입니다.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .default, handler: nil)
                    
                    alert.addAction(action)
                    self.window?.rootViewController?.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        
    }
    
    @objc func handlePasswordTextfield() {
        if (passwordTextfield.text?.count)! < 4 {
            
            presentAlert(withTitle: "입력오류", withMessage: "비밀번호를 4자 이상 입력해 주세요.")
        }
    }
    
    @objc func handleDoubleCheckPassword() {
        
        if passwordTextfield.text != doubleCheckPasswordTextfield.text {
            passwordCheckLabel.text = "비밀번호가 일치하지 않습니다."
            isPasswordChecked = false
        } else {
            passwordCheckLabel.text = "비밀번호가 일치합니다."
            isPasswordChecked = true
        }
        
        if passwordTextfield.text == "" || doubleCheckPasswordTextfield.text == "" {
            presentAlert(withTitle: "입력오류", withMessage: "비밀번호를 입력해 주세요")
            isPasswordChecked = false
        }
    }
    

    
  
    
    @objc func hanldeButtonForMale() {
        if isMaleChecked {
            checkBoxForMale.layer.borderColor = UIColor.init(hexString: "#b5b5b5").cgColor
            isMaleChecked = false
        } else {
            checkBoxForMale.layer.borderColor = UIColor.init(hexString: "#3831bb").cgColor
            checkBoxForFemale.layer.borderColor = UIColor.init(hexString: "#b5b5b5").cgColor
            isMaleChecked = true
        }
     
    }
    
    @objc func hanldeButtonForFemale() {
        if isFemaleChecked {
            checkBoxForFemale.layer.borderColor = UIColor.init(hexString: "#b5b5b5").cgColor
            isFemaleChecked = false
        } else {
            checkBoxForFemale.layer.borderColor = UIColor.init(hexString: "#f64b7b").cgColor
            checkBoxForMale.layer.borderColor = UIColor.init(hexString: "#b5b5b5").cgColor
            isFemaleChecked = true
        }
    }
  
    @objc func handlePromise() {
        if isPromiseChecked {
            promiseButton.setImage(nil, for: .normal)
            promiseButton.layer.borderWidth = 1
            isPromiseChecked = false
        } else {
            promiseButton.setImage(#imageLiteral(resourceName: "check"), for: .normal)
            promiseButton.layer.borderWidth = 0
            isPromiseChecked = true
        }
    }
    
    @objc func handleAgree() {
        if isAgreeChecked {
            agreeButton.setImage(nil, for: .normal)
            agreeButton.layer.borderWidth = 1
            isAgreeChecked = false
        } else {
            agreeButton.setImage(#imageLiteral(resourceName: "check"), for: .normal)
            agreeButton.layer.borderWidth = 0
            isAgreeChecked = true
        }
    }
    
    @objc func handleCompleteSignUp() {
        
        if isUsernameChecked == false {
            presentAlert(withTitle: "입력오류", withMessage: "아이디를 확인 주세요.")
        } else if isNicknameChecked == false {
           presentAlert(withTitle: "입력오류", withMessage: "닉네임를 확인 주세요.")
        } else if isPasswordChecked == false {
            presentAlert(withTitle: "입력오류", withMessage: "비밀번호를 확인해 주세요.")
        } else if isPromiseChecked == false {
            presentAlert(withTitle: "입력오류", withMessage: "\"약속합니다\"에 동의가 되지 않았습니다.")
        } else if isAgreeChecked == false {
            presentAlert(withTitle: "입력오류", withMessage: "\"개인정보동의\"에 동의가 되지 않았습니다.")
        } else if isAgreementViewed == false {
            presentAlert(withTitle: "입력오류", withMessage: "\"서약내용 보기\"에서 동의를 해 주세요.")
        } else {
            registerAccount()
        }   
    }
 
    func presentAlert(withTitle title: String, withMessage message: String) {
        let alert = UIAlertController(title: "\(title)", message: "\(message).", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(action)
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func registerAccount() {
        if isMaleChecked {
            gender = 1
        } else if isFemaleChecked {
            gender = 0
        } else {
            gender = 2
        }
        
        guard let username = usernameTextfield.text, let nickName = nicknameTextfield.text, let password = passwordTextfield.text else {

            let alert = UIAlertController(title: "입력오류", message: "빈칸을 모두 채워주세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)

            alert.addAction(action)
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            return
        }

        if dateOfBirthTextfield.text == nil {
          
            let dateOfBirth = ""
            APIService.instance.registerNewAccount(withUsername: username, withNickname: nickName, withPassword: password, withGender: gender!, withDOB: dateOfBirth, withEmail: emailAddressVerified!, withPhoneNumber: phoneNumberVerified!) { (result) in
                if result == "true" {
                    let alert = UIAlertController(title: "회원가입 성공!", message: "회원가입을 축하드립니다.", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
                        //회원가입 완료시 다시 로그인 페이로 돌아가기 위해서
                        NotificationCenter.default.post(name: Notification.Name("complete"), object: self, userInfo: ["result": "good"])
                    })
                    
                    alert.addAction(action)
                    self.window?.rootViewController?.present(alert, animated: true, completion: nil)
                    
                } else {
                    print("something went wrong!")
                }
            }
            
        } else {
            guard let dateOfBirth = dateOfBirthTextfield.text else { return }
            
            if dateOfBirth == "" {
                let alert = UIAlertController(title: "주의", message: "생년월일을 통해 비밀번호 찾기를 하고 있습니다. 정말 그냥 진짜로 그냥 넘길거에요?", preferredStyle: .alert)
                let yesAction = UIAlertAction(title: "네", style: .default, handler: { (_) in
                    APIService.instance.registerNewAccount(withUsername: username, withNickname: nickName, withPassword: password, withGender: self.gender!, withDOB: dateOfBirth, withEmail: emailAddressVerified!, withPhoneNumber: phoneNumberVerified!) { (result) in
                        if result == "true" {
                            let alert = UIAlertController(title: "회원가입 성공!", message: "회원가입을 축하드립니다.", preferredStyle: .alert)
                            
                            let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
                                //회원가입 완료시 다시 로그인 페이로 돌아가기 위해서
                                NotificationCenter.default.post(name: Notification.Name("complete"), object: self, userInfo: ["result": "good"])
                            })
                            
                            alert.addAction(action)
                            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
                            
                        } else {
                            print("something went wrong!")
                        }
                    }
                })
                
                let noAction = UIAlertAction(title: "아니요", style: .default, handler: { (_) in
                    self.dateOfBirthTextfield.becomeFirstResponder()
                })
                
                alert.addAction(yesAction)
                alert.addAction(noAction)
                window?.rootViewController?.present(alert, animated: true, completion: nil)
                
            } else {
                APIService.instance.registerNewAccount(withUsername: username, withNickname: nickName, withPassword: password, withGender: gender!, withDOB: dateOfBirth, withEmail: emailAddressVerified!, withPhoneNumber: phoneNumberVerified!) { (result) in
                    if result == "true" {
                        let alert = UIAlertController(title: "회원가입 성공!", message: "회원가입을 축하드립니다.", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
                            //회원가입 완료시 다시 로그인 페이로 돌아가기 위해서
                            NotificationCenter.default.post(name: Notification.Name("complete"), object: self, userInfo: ["result": "good"])
                        })
                        
                        alert.addAction(action)
                        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
                        
                    } else {
                        print("something went wrong!")
                    }
                }
            }
        }
    }

    
    @objc func handleBackToOriginal() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.contentView.frame.origin.y = 0
        }, completion: nil)
    }
    
    @objc func handleOpenAgreement() {
        isAgreementViewed = true
        let agreementViewController = AgreementViewController()
        window?.rootViewController?.present(agreementViewController, animated: true, completion: {
            self.isAgreementViewed = true
        })
    }
}

































