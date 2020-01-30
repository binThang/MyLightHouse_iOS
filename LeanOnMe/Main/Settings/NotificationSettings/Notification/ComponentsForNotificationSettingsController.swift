//
//  HandlersForNotificationSettingsController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 31/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension NotificationSettingsController {
    
    func setupComponents() {
        view.addSubview(pushTitle)
        view.addSubview(pushToggle)
        view.addSubview(borderOne)
        
        view.addSubview(commentTitle)
        view.addSubview(commentToggle)
        view.addSubview(borderTwo)
        
        view.addSubview(sympathyTitle)
        view.addSubview(sympathyToggle)
        view.addSubview(borderThree)
        
        view.addSubview(niceWordsTitle)
        view.addSubview(niceWordsToggle)
        view.addSubview(borderFour)
        
        view.addSubview(vibrationTitle)
        view.addSubview(vibrationToggle)
        view.addSubview(borderFive)
        
        view.addSubview(doNotDisturbTitle)
        view.addSubview(borderSix)
        view.addSubview(dimmedView)
        view.addSubview(doNotDisturbView.view)

        dimmedView.frame = view.bounds
        dimmedView.alpha = 0
        
        doNotDisturbView.view.frame = CGRect(x:view.frame.width/10, y: view.frame.height + 10, width: view.frame.height/3, height: 0)
        
        NSLayoutConstraint.activate([
            pushTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            pushTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            pushTitle.widthAnchor.constraint(equalToConstant: 200),
            pushTitle.heightAnchor.constraint(equalToConstant: 25),
            
            pushToggle.centerYAnchor.constraint(equalTo: pushTitle.centerYAnchor),
            pushToggle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            pushToggle.widthAnchor.constraint(equalToConstant: 45),
            pushToggle.heightAnchor.constraint(equalToConstant: 25),
            
            borderOne.topAnchor.constraint(equalTo: pushTitle.bottomAnchor, constant: 20),
            borderOne.leadingAnchor.constraint(equalTo: pushTitle.leadingAnchor),
            borderOne.trailingAnchor.constraint(equalTo: pushToggle.trailingAnchor),
            borderOne.heightAnchor.constraint(equalToConstant: 1),
            
            
            commentTitle.topAnchor.constraint(equalTo: borderOne.bottomAnchor, constant: 20),
            commentTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            commentTitle.widthAnchor.constraint(equalToConstant: 200),
            commentTitle.heightAnchor.constraint(equalToConstant: 25),
            
            commentToggle.centerYAnchor.constraint(equalTo: commentTitle.centerYAnchor),
            commentToggle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            commentToggle.widthAnchor.constraint(equalToConstant: 45),
            commentToggle.heightAnchor.constraint(equalToConstant: 25),
            
            borderTwo.topAnchor.constraint(equalTo: commentTitle.bottomAnchor, constant: 20),
            borderTwo.leadingAnchor.constraint(equalTo: commentTitle.leadingAnchor),
            borderTwo.trailingAnchor.constraint(equalTo: commentToggle.trailingAnchor),
            borderTwo.heightAnchor.constraint(equalToConstant: 1),
            
            sympathyTitle.topAnchor.constraint(equalTo: borderTwo.bottomAnchor, constant: 20),
            sympathyTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            sympathyTitle.widthAnchor.constraint(equalToConstant: 200),
            sympathyTitle.heightAnchor.constraint(equalToConstant: 25),
            
            sympathyToggle.centerYAnchor.constraint(equalTo: sympathyTitle.centerYAnchor),
            sympathyToggle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            sympathyToggle.widthAnchor.constraint(equalToConstant: 45),
            sympathyToggle.heightAnchor.constraint(equalToConstant: 25),
            
            borderThree.topAnchor.constraint(equalTo: sympathyTitle.bottomAnchor, constant: 20),
            borderThree.leadingAnchor.constraint(equalTo: sympathyTitle.leadingAnchor),
            borderThree.trailingAnchor.constraint(equalTo: sympathyToggle.trailingAnchor),
            borderThree.heightAnchor.constraint(equalToConstant: 1),
            
            niceWordsTitle.topAnchor.constraint(equalTo: borderThree.bottomAnchor, constant: 20),
            niceWordsTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            niceWordsTitle.widthAnchor.constraint(equalToConstant: 200),
            niceWordsTitle.heightAnchor.constraint(equalToConstant: 25),
            
            niceWordsToggle.centerYAnchor.constraint(equalTo: niceWordsTitle.centerYAnchor),
            niceWordsToggle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            niceWordsToggle.widthAnchor.constraint(equalToConstant: 45),
            niceWordsToggle.heightAnchor.constraint(equalToConstant: 25),
            
            borderFour.topAnchor.constraint(equalTo: niceWordsTitle.bottomAnchor, constant: 20),
            borderFour.leadingAnchor.constraint(equalTo: niceWordsTitle.leadingAnchor),
            borderFour.trailingAnchor.constraint(equalTo: niceWordsToggle.trailingAnchor),
            borderFour.heightAnchor.constraint(equalToConstant: 1),
            
            vibrationTitle.topAnchor.constraint(equalTo: borderFour.bottomAnchor, constant: 20),
            vibrationTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            vibrationTitle.widthAnchor.constraint(equalToConstant: 200),
            vibrationTitle.heightAnchor.constraint(equalToConstant: 25),
            
            vibrationToggle.centerYAnchor.constraint(equalTo: vibrationTitle.centerYAnchor),
            vibrationToggle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            vibrationToggle.widthAnchor.constraint(equalToConstant: 45),
            vibrationToggle.heightAnchor.constraint(equalToConstant: 25),
            
            borderFive.topAnchor.constraint(equalTo: vibrationTitle.bottomAnchor, constant: 20),
            borderFive.leadingAnchor.constraint(equalTo: vibrationTitle.leadingAnchor),
            borderFive.trailingAnchor.constraint(equalTo: vibrationToggle.trailingAnchor),
            borderFive.heightAnchor.constraint(equalToConstant: 1),
            
            doNotDisturbTitle.topAnchor.constraint(equalTo: borderFive.bottomAnchor, constant: 20),
            doNotDisturbTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            doNotDisturbTitle.trailingAnchor.constraint(equalTo: borderFive.trailingAnchor),
            doNotDisturbTitle.heightAnchor.constraint(equalToConstant: 25),
            
            
            borderSix.topAnchor.constraint(equalTo: doNotDisturbTitle.bottomAnchor, constant: 20),
            borderSix.leadingAnchor.constraint(equalTo: vibrationTitle.leadingAnchor),
            borderSix.trailingAnchor.constraint(equalTo: vibrationToggle.trailingAnchor),
            borderSix.heightAnchor.constraint(equalToConstant: 1),
            
            ])
    }
}





























































