//
//  ComponentsForSignUpViewCell.swift
//  LeanOnMe
//
//  Created by Justin Ji on 18/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension SignUpViewCell {
    
    func addComponents() {
        addSubview(welcomeTitle)
        addSubview(subtitle)
        addSubview(usernameLabel)
        addSubview(usernameTextfield)
        addSubview(verfiyUsernameButton)
        addSubview(nicknameLabel)
        addSubview(nicknameTextfield)
        addSubview(verfiyNicknameButton)
        addSubview(passwordLabel)
        addSubview(passwordTextfield)
        addSubview(passwordCheckLabel)
        addSubview(doubleCheckPasswordTextfield)
        addSubview(genderLabel)
        addSubview(checkBoxForMale)
        addSubview(maleLabel)
        addSubview(checkBoxForFemale)
        addSubview(femaleLabel)
        addSubview(dateOfBirthLabel)
        addSubview(dateOfBirthTextfield)
        addSubview(openAgreementButton)
        addSubview(promiseButton)
        addSubview(promiseLabel)
        addSubview(agreeButton)
        addSubview(agreeLabel)
        addSubview(completeButton)
        
        
        NSLayoutConstraint.activate([
            welcomeTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 56),
            welcomeTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            welcomeTitle.widthAnchor.constraint(equalToConstant: 120),
            welcomeTitle.heightAnchor.constraint(equalToConstant: 30),
            
            subtitle.topAnchor.constraint(equalTo: welcomeTitle.bottomAnchor, constant: 4),
            subtitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            subtitle.widthAnchor.constraint(equalToConstant: 150),
            subtitle.heightAnchor.constraint(equalToConstant: 15),
            
            usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 140),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            usernameLabel.widthAnchor.constraint(equalToConstant: 50),
            usernameLabel.heightAnchor.constraint(equalToConstant: 15),
            
            verfiyUsernameButton.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 9),
            verfiyUsernameButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            verfiyUsernameButton.widthAnchor.constraint(equalToConstant: 70),
            verfiyUsernameButton.heightAnchor.constraint(equalToConstant: 40),
            
            
            usernameTextfield.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 9),
            usernameTextfield.leadingAnchor.constraint(equalTo: contentView.leadingAnchor
                , constant: 18),
            usernameTextfield.trailingAnchor.constraint(equalTo: verfiyUsernameButton.leadingAnchor, constant: 1),
            usernameTextfield.heightAnchor.constraint(equalToConstant: 40),
            
            nicknameLabel.topAnchor.constraint(equalTo: usernameTextfield.bottomAnchor, constant: 19),
            nicknameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            nicknameLabel.widthAnchor.constraint(equalToConstant: 50),
            nicknameLabel.heightAnchor.constraint(equalToConstant: 15),
            
            verfiyNicknameButton.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 9),
            verfiyNicknameButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            verfiyNicknameButton.widthAnchor.constraint(equalToConstant: 70),
            verfiyNicknameButton.heightAnchor.constraint(equalToConstant: 40),
            
            
            nicknameTextfield.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 9),
            nicknameTextfield.leadingAnchor.constraint(equalTo: contentView.leadingAnchor
                , constant: 18),
            nicknameTextfield.trailingAnchor.constraint(equalTo: verfiyNicknameButton.leadingAnchor, constant: 1),
            nicknameTextfield.heightAnchor.constraint(equalToConstant: 40),
            
            passwordLabel.topAnchor.constraint(equalTo: nicknameTextfield.bottomAnchor, constant: 19),
            passwordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            passwordLabel.widthAnchor.constraint(equalToConstant: 50),
            passwordLabel.heightAnchor.constraint(equalToConstant: 15),
            
            passwordTextfield.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 9),
            passwordTextfield.leadingAnchor.constraint(equalTo: contentView.leadingAnchor
                , constant: 18),
            passwordTextfield.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            passwordTextfield.heightAnchor.constraint(equalToConstant: 40),
            
            doubleCheckPasswordTextfield.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 6),
            doubleCheckPasswordTextfield.leadingAnchor.constraint(equalTo: contentView.leadingAnchor
                , constant: 18),
            doubleCheckPasswordTextfield.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            doubleCheckPasswordTextfield.heightAnchor.constraint(equalToConstant: 40),
            
            passwordCheckLabel.topAnchor.constraint(equalTo: doubleCheckPasswordTextfield.bottomAnchor, constant: 11),
            passwordCheckLabel.leadingAnchor.constraint(equalTo: doubleCheckPasswordTextfield.leadingAnchor),
            passwordCheckLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            passwordCheckLabel.heightAnchor.constraint(equalToConstant: 12),
            
            genderLabel.topAnchor.constraint(equalTo: passwordCheckLabel.bottomAnchor, constant: 19),
            genderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            genderLabel.widthAnchor.constraint(equalToConstant: 200),
            genderLabel.heightAnchor.constraint(equalToConstant: 15),
            
            checkBoxForMale.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 23),
            checkBoxForMale.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 122),
            checkBoxForMale.widthAnchor.constraint(equalToConstant: 17),
            checkBoxForMale.heightAnchor.constraint(equalToConstant: 17),
            
            maleLabel.topAnchor.constraint(equalTo: checkBoxForMale.topAnchor),
            maleLabel.leadingAnchor.constraint(equalTo: checkBoxForMale.trailingAnchor, constant: 5),
            maleLabel.widthAnchor.constraint(equalToConstant: 17),
            maleLabel.heightAnchor.constraint(equalToConstant: 17),
            
            checkBoxForFemale.topAnchor.constraint(equalTo: checkBoxForMale.topAnchor),
            checkBoxForFemale.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -122),
            checkBoxForFemale.widthAnchor.constraint(equalToConstant: 17),
            checkBoxForFemale.heightAnchor.constraint(equalToConstant: 17),
            
            femaleLabel.topAnchor.constraint(equalTo: checkBoxForMale.topAnchor),
            femaleLabel.leadingAnchor.constraint(equalTo: checkBoxForFemale.trailingAnchor, constant: 5),
            femaleLabel.widthAnchor.constraint(equalToConstant: 17),
            femaleLabel.heightAnchor.constraint(equalToConstant: 17),
            
            dateOfBirthLabel.topAnchor.constraint(equalTo: checkBoxForFemale.bottomAnchor, constant: 62),
            dateOfBirthLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            dateOfBirthLabel.widthAnchor.constraint(equalToConstant: 200),
            dateOfBirthLabel.heightAnchor.constraint(equalToConstant: 15),
            
            dateOfBirthTextfield.topAnchor.constraint(equalTo: dateOfBirthLabel.bottomAnchor, constant: 8),
            dateOfBirthTextfield.leadingAnchor.constraint(equalTo: contentView.leadingAnchor
                , constant: 18),
            dateOfBirthTextfield.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            dateOfBirthTextfield.heightAnchor.constraint(equalToConstant: 40),
            
            openAgreementButton.topAnchor.constraint(equalTo: dateOfBirthTextfield.bottomAnchor, constant: 18),
            openAgreementButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            openAgreementButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            openAgreementButton.heightAnchor.constraint(equalToConstant: 41),
            
            promiseButton.topAnchor.constraint(equalTo: openAgreementButton.bottomAnchor, constant: 18),
            promiseButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 65),
            promiseButton.widthAnchor.constraint(equalToConstant: 15),
            promiseButton.heightAnchor.constraint(equalToConstant: 15),
            
            promiseLabel.centerYAnchor.constraint(equalTo: promiseButton.centerYAnchor),
            promiseLabel.leadingAnchor.constraint(equalTo: promiseButton.trailingAnchor, constant: 11),
            promiseLabel.widthAnchor.constraint(equalToConstant: 60),
            promiseLabel.heightAnchor.constraint(equalToConstant: 20),
            
            agreeLabel.topAnchor.constraint(equalTo: promiseLabel.topAnchor),
            agreeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -65),
            agreeLabel.widthAnchor.constraint(equalToConstant: 70),
            agreeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            agreeButton.centerYAnchor.constraint(equalTo: agreeLabel.centerYAnchor),
            agreeButton.trailingAnchor.constraint(equalTo: agreeLabel.leadingAnchor, constant: -11),
            agreeButton.widthAnchor.constraint(equalToConstant: 15),
            agreeButton.heightAnchor.constraint(equalToConstant: 15),
            
            completeButton.topAnchor.constraint(equalTo: promiseLabel.bottomAnchor, constant: 18),
            completeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            completeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            completeButton.heightAnchor.constraint(equalToConstant: 47)
            ])
        
    }
    
}

