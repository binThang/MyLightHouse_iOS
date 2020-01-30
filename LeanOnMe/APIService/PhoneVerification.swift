//
//  PhoneVerification.swift
//  LeanOnMe
//
//  Created by Justin Ji on 25/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit
import Firebase

extension APIService {
    
    
    func checkIfPhoneNumberIsAvailable(withPhoneNumber phoneNumber: String, completionHandler completion: @escaping(String) -> Void) {
        
        let url = URL(string: baseURL + "/member/checkPhone")
        let postString = "member_phone=\(phoneNumber)"
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        request.addValue("gh_mobile{}", forHTTPHeaderField: "User-Agent")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: AnyObject]
                    
                    guard let result = json!["return"] as? String else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        completion(result)
                    }
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
    
    func phoneVerification(withPhoneNumber phoneNumber: String, withRandomNumber randomNumber: String, completionHandler completion: @escaping(String) -> Void) {
        guard let token = Messaging.messaging().fcmToken else { return }
        let url = URL(string: baseURL + "/member/smsCk")
        let postString = "number=\(randomNumber)&phone=\(phoneNumber)"
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        request.addValue("gh_mobile{\(token)}", forHTTPHeaderField: "User-Agent")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: AnyObject]
                    
                    
                    guard let result = json!["return"] as? String else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        completion(result)
                    }
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
}
