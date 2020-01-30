//
//  RegisterNewAccount.swift
//  LeanOnMe
//
//  Created by Justin Ji on 25/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit
import Firebase

extension APIService {
    
    func registerNewAccount(withUsername username: String, withNickname nickname: String, withPassword password: String, withGender gender: Int, withDOB dateOfBirth: String, withEmail email: String, withPhoneNumber phoneNumber: String, completionHandler completion: @escaping(String) -> Void) {
        
        let url = URL(string: baseURL + "/member/insert")
        let postString = "member_id=\(username)&member_name=\(nickname)&member_pass=\(password)&member_gender=\(gender)&member_birth=\(dateOfBirth)&member_email=\(email)&member_phone=\(phoneNumber)&member_device=1"
        
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
                    
                    print(response.debugDescription)
                    print(json!)
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
