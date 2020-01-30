//
//  HandlersForNotificationSettingsController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 31/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit
import AudioToolbox

extension NotificationSettingsController {
    
    func setupToggles() {
        APIService.instance.fetchNotificationSettings { (result) in
            
            DispatchQueue.main.async {
                result["push1"] as? String == "1" ? self.pushToggle.setBackgroundImage(#imageLiteral(resourceName: "on"), for: .normal): self.pushToggle.setBackgroundImage(#imageLiteral(resourceName: "off"), for: .normal)
                
                result["push2"] as? String == "1" ? self.commentToggle.setBackgroundImage(#imageLiteral(resourceName: "on"), for: .normal): self.commentToggle.setBackgroundImage(#imageLiteral(resourceName: "off"), for: .normal)
                
                result["push3"] as? String == "1" ? self.sympathyToggle.setBackgroundImage(#imageLiteral(resourceName: "on"), for: .normal): self.sympathyToggle.setBackgroundImage(#imageLiteral(resourceName: "off"), for: .normal)
                
                 result["push4"] as? String == "1" ? self.niceWordsToggle.setBackgroundImage(#imageLiteral(resourceName: "on"), for: .normal): self.niceWordsToggle.setBackgroundImage(#imageLiteral(resourceName: "off"), for: .normal)
            }
        }
    }
    
    @objc func handlePush() {
        
        if isPushOn {
            pushToggle.setBackgroundImage(#imageLiteral(resourceName: "off"), for: .normal)
        APIService.instance.changeNotificationStatus(withSwichNumber: "1", withPushStatus: "0")
            isPushOn = false
        } else {
            pushToggle.setBackgroundImage(#imageLiteral(resourceName: "on"), for: .normal)
        APIService.instance.changeNotificationStatus(withSwichNumber: "1", withPushStatus: "1")
            isPushOn = true
        }
        
    }
    
    @objc func handleComment() {
        
        
        if isCommentOn {
            commentToggle.setBackgroundImage(#imageLiteral(resourceName: "off"), for: .normal)
        APIService.instance.changeNotificationStatus(withSwichNumber: "2", withPushStatus: "0")
            isCommentOn = false
        } else {
            commentToggle.setBackgroundImage(#imageLiteral(resourceName: "on"), for: .normal)
        APIService.instance.changeNotificationStatus(withSwichNumber: "2", withPushStatus: "1")
            isCommentOn = true
        }
    }
    
    @objc func handleSympathy() {
        
        if isSympathyOn {
            sympathyToggle.setBackgroundImage(#imageLiteral(resourceName: "off"), for: .normal)
        APIService.instance.changeNotificationStatus(withSwichNumber: "3", withPushStatus: "0")
            isSympathyOn = false
        } else {
            sympathyToggle.setBackgroundImage(#imageLiteral(resourceName: "on"), for: .normal)
        APIService.instance.changeNotificationStatus(withSwichNumber: "3", withPushStatus: "1")
            isSympathyOn = true
        }
    }
    
    @objc func handleNiceWords() {
        if isNiceWordsOn {
            niceWordsToggle.setBackgroundImage(#imageLiteral(resourceName: "off"), for: .normal)
        APIService.instance.changeNotificationStatus(withSwichNumber: "4", withPushStatus: "0")
            isNiceWordsOn = false
        } else {
            niceWordsToggle.setBackgroundImage(#imageLiteral(resourceName: "on"), for: .normal)
        APIService.instance.changeNotificationStatus(withSwichNumber: "4", withPushStatus: "1")
            isNiceWordsOn = true
        }
    }
    
    @objc func handleVibration() {
        
        if isVibrationOn {
            vibrationToggle.setBackgroundImage(#imageLiteral(resourceName: "off"), for: .normal)
            isVibrationOn = false
            UserDefaults.standard.set("false", forKey: "vibration")
        } else {
            vibrationToggle.setBackgroundImage(#imageLiteral(resourceName: "on"), for: .normal)
            isVibrationOn = true
            UserDefaults.standard.set("true", forKey: "vibration")

        }
    }
    
    
    @objc func handleDoNotDisturb() {
        
        doNotDisturbView.view.frame = CGRect(x:view.frame.width/10, y: view.frame.height, width: view.frame.height/3, height: 0)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

            self.dimmedView.alpha = 1
            self.doNotDisturbView.view.frame = CGRect(x: self.view.frame.width/10, y: self.view.frame.height/4, width: (self.view.frame.width/10)*8, height: 250)
        }, completion: nil)
        
    }
    
    @objc func handleDimmedView() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        
            self.dimmedView.alpha = 0
            self.doNotDisturbView.view.frame = CGRect(x: self.view.frame.width/10, y: self.view.frame.height + 10, width: (self.view.frame.width/10)*8, height: 0)
        }, completion: nil)
        
    }
}




























































