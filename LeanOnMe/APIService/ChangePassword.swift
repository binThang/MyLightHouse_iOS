//
//  ChangePassword.swift
//  LeanOnMe
//
//  Created by Justin Ji on 20/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit
import Firebase

extension APIService {
    
    func findPasswordWithPhoneNumber(withUsername username: String, withPhoneNumber phoneNumber: String, withDOB dateOfBirth: String, completionHandler completion: @escaping(String) -> Void) {
        
        let url = URL(string: baseURL + "/findPass")
        let postString = "member_id=\(username)&member_phone=\(phoneNumber)&member_birth=\(dateOfBirth)"
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
    
    func changePassword(withUsername username: String, withPassword password: String, completionHandler completion: @escaping(String) -> Void) {
        
        let url = URL(string: baseURL + "/updatePass")
        let postString = "member_id=\(username)&pass=\(password)"
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
    
    func findPasswordWithEmail(withUsername username: String, withEmail email: String, withDOB dateOfBirth: String, completionHandler completion: @escaping(String) -> Void) {
        
        guard let token = Messaging.messaging().fcmToken else { return }
        let url = URL(string: baseURL + "/findIdEmail")
        let postString = "member_id=\(username)&member_email=\(email)&member_birth=\(dateOfBirth)"
        print(postString)
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
