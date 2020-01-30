//
//  HandlersForLoginController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 18/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension LogInController {
    
    @objc func handleDismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func handleLogIn() {
        if usernameTextfield.text == "" {
            let alert = UIAlertController(title: "입력오류", message: "아이디를 입력해 주세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        } else if passwordTextfield.text == "" {
            let alert = UIAlertController(title: "입력오류", message: "비밀번호를 입력해 주세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            
            guard let username = usernameTextfield.text, let password = passwordTextfield.text else { return }
            
            print(username, password)
            APIService.instance.loginIn(withUsername: username, withPassword: password, completionHandler: { (result, indexNumber) in
                
                if result == "true" {
                    
                    UserDefaults.standard.set(true, forKey: "isSignedIn")
                    UserDefaults.standard.synchronize()
                    
                    let alert = UIAlertController(title: "로그인 성공", message: "메인 페이지로 이동합니다.", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
                        
                            let mainViewController = MainViewController()
                            self.navigationController?.pushViewController(mainViewController, animated: true)
                        })
                   
                    
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    let alert = UIAlertController(title: "로그인 실패", message: "아이디 또는 비밀번호를 확인해 주세요..", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
                        
                        self.usernameTextfield.becomeFirstResponder()
                    })
                    
                    
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
                
                UserDefaults.standard.set(indexNumber, forKey: "indexNumber")
                UserDefaults.standard.synchronize()
                
                
            })
        }
        
    }
    
    @objc func handleSignUp() {
      
        let verificationController = VerificationController()
        navigationController?.pushViewController(verificationController, animated: true)
    }
    
    @objc func handleFindUsername() {
        let optionsToFindUserNameController = OptionsToFindUserNameController()
        navigationController?.pushViewController(optionsToFindUserNameController, animated: true)
    }
    
    @objc func handleFindPassword() {
        let optionsToFindPasswordViewController = OptionsToFindPasswordViewController()
        navigationController?.pushViewController(optionsToFindPasswordViewController, animated: true)
    }
}
