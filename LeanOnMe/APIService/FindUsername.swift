//
//  FindUsername.swift
//  LeanOnMe
//
//  Created by Justin Ji on 20/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit
import Firebase

extension APIService {
    
    typealias findUsernameCompletionhandler = (String?, String?) -> Void
    
    func findUsernameWithPhoneNumber(withPhoneNumber phoneNumber: String, withDOB dateOfBirth: String, completionHandler completion: @escaping findUsernameCompletionhandler) {
        
        let url = URL(string: baseURL + "/findId")
        let postString = "member_phone=\(phoneNumber)&member_birth=\(dateOfBirth)"
        guard let token = Messaging.messaging().fcmToken else { return }
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
                    
                    
                    if let result = json!["return"] as? String, result == "false" {
                        DispatchQueue.main.async {
                            completion("false", nil)
                        }
                    }
                    
                    if let result = json!["return"] as? String, result == "true", let username = json!["id"] as? String {
                        DispatchQueue.main.async {
                            completion(result, username)
                        }
                    }
                    
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func findUsernameWithEmail(withEmail email: String, withDOB dateOfBirth: String, completionHandler completion: @escaping findUsernameCompletionhandler) {
        
        let url = URL(string: baseURL + "/findIdEmail")
        let postString = "member_email=\(email)&member_birth=\(dateOfBirth)"
        guard let token = Messaging.messaging().fcmToken else { return }
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
                    
                    if let result = json!["return"] as? String, result == "false" {
                        DispatchQueue.main.async {
                            completion("false", nil)
                        }
                    }
                    
                    if let result = json!["return"] as? String, result == "true", let username = json!["id"] as? String {
                        DispatchQueue.main.async {
                            completion(result, username)
                        }
                    }
                    
                    
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
}
