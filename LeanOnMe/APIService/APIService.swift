//
//  APIService.swift
//  LeanOnMe
//
//  Created by Justin Ji on 18/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit
import Firebase

class APIService
{
    static let instance = APIService()
    
    typealias signInCompletionHandler = (String?, String?) -> Void
    
    func loginIn(withUsername username: String, withPassword password: String, completionHandler completion: @escaping signInCompletionHandler) {
        
        let url = URL(string: baseURL + "/member/login")
        let postString = "member_id=\(username)&member_pass=\(password)"
        
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
                    
                    
                    if let result = json!["return"] as? String {
                        DispatchQueue.main.async {
                            completion(result, nil)
                        }
                        
                    }
                    
                    if let result = json!["return"] as? String, let indexNumber = json!["member_idx"] as? String {
                        DispatchQueue.main.async {
                            completion(result, indexNumber)
                        }
                    }
                    
                } catch {
                    
                    print(error)
                }
            }
        }.resume()
    }
    
    func logOut(completionHandler completion: @escaping (String) ->  Void) {
        
        let url = URL(string: baseURL + "/member/logout")
        guard let token = Messaging.messaging().fcmToken else { return }
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("gh_mobile{\(token)}", forHTTPHeaderField: "User-Agent")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: AnyObject]
                    
                    
                    if let result = json!["return"] as? String {
                        DispatchQueue.main.async {
                            completion(result)
                        }
                        
                    }
                    
                } catch {
                    
                    print(error)
                }
            }
            }.resume()
    }
    
    
    
    //MARK: Check Username
    func checkUsername(withUsername username: String, completionHandler completion: @escaping(String) -> Void) {
     
        guard let token = Messaging.messaging().fcmToken else { return }
        let url = URL(string: baseURL + "/member/selectId")
        let postString = "member_id=\(username)"
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
    
    //MARK: Check Nickname
    func checkNickname(withNickname nickname: String, completionHandler completion: @escaping(String) -> Void) {
        
        guard let token = Messaging.messaging().fcmToken else { return }
        let url = URL(string: baseURL + "/member/selectNick")
        let postString = "member_id=\(nickname)"
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































































