//
//  Notification.swift
//  LeanOnMe
//
//  Created by Justin Ji on 30/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension APIService {
    
    func fetchNotificationSettings(completionHandler completion: @escaping ([String: AnyObject]) -> Void) {
        
      guard let memberIdxNumber = UserDefaults.standard.object(forKey: "indexNumber") as? String else { return }
        
        let url = URL(string: baseURL + "/select_push")
        let postString = "member_idx=\(memberIdxNumber)"

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
                    
                    completion(json!)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func changeNotificationStatus(withSwichNumber number: String, withPushStatus status: String) {
        
        guard let memberIdxNumber = UserDefaults.standard.object(forKey: "indexNumber") as? String else { return }
        
        let url = URL(string: baseURL + "/update_push/\(number)/")
        let postString = "member_idx=\(memberIdxNumber)&push=\(status)"
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        request.addValue("gh_mobile{}", forHTTPHeaderField: "User-Agent")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            } else {
               
            }
            }.resume()
    }
    
    func doNotDisturb(withStart start: String, withEnd end: String) {
        
        guard let memberIdxNumber = UserDefaults.standard.object(forKey: "indexNumber") as? String else { return }
        
        let url = URL(string: baseURL + "/disturbance")
        let postString = "member_idx=\(memberIdxNumber)&nopushtime1=\(start)&nopushtime2=\(end)"
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        request.addValue("gh_mobile{}", forHTTPHeaderField: "User-Agent")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            } else {
               
            }
        }.resume()
    }
    
    
}
