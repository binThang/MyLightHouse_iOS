//
//  HandlersForDoNotDisturb.swift
//  LeanOnMe
//
//  Created by Justin Ji on 31/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension DoNotDisturbView {
    
    @objc func handleHourUp() {
        startingTime += 1
        if startingTime > 24 {
            startingTime = 0
        }
        
        startingLabel.text = String(format: "%02d", startingTime)
    }
    
    @objc func handleHourDown() {
        startingTime -= 1
        if startingTime < 0 {
            startingTime = 24
        }
        startingLabel.text = String(format: "%02d", startingTime)
    }
    
    @objc func handleMinuteUp() {
        endingTime += 1
        if endingTime > 24 {
            endingTime = 0
        }
        
        endingLabel.text = String(format: "%02d", endingTime)
    }
    
    @objc func handleMinuteDown() {
        endingTime -= 1
        if endingTime < 0 {
            endingTime = 24
        }
        endingLabel.text = String(format: "%02d", endingTime)
    }
    
    @objc func handleComplete() {
        
        guard let startingTime = startingLabel.text, let endingTime = endingLabel.text else { return }
        APIService.instance.doNotDisturb(withStart: "\(startingTime):00:00", withEnd: "\(endingTime):00:00")
        
        UserDefaults.standard.set([startingTime, endingTime], forKey: "DoNotDisturb")
        UserDefaults.standard.synchronize()
        
        NotificationCenter.default.post(name: Notification.Name("timeSet"), object: self, userInfo: ["result": "good"])
        
    }
}



























































