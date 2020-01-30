//
//  HandlersForSignUpViewController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 18/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension SignUpViewController {
    
    @objc func handleDismissKeyboard() {
        view.endEditing(true)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            
            self.collectionView.frame.origin.y = 0
            
        }, completion: nil)
    }
    
    @objc func handlePhoneNumberTextfield() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            
            self.view.frame = CGRect(x: 0, y: -215, width: self.view.frame.width, height: self.view.frame.height)
            
        }, completion: nil)
    }
    
    @objc func handleDOBTextfield() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.collectionView.frame.origin.y = -250
        }, completion: nil)
    }
    
    @objc func handleAgreeButton() {
        view.endEditing(true)
        let agreementViewController = AgreementViewController()
        navigationController?.present(agreementViewController, animated: true)
    }
    
    @objc func completeSignUp(_ notification: Notification) {
    
        let loginController = LogInController()
        navigationController?.pushViewController(loginController, animated: true)
    }
}
