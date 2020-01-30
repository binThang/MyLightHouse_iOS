//
//  Enquery.swift
//  LeanOnMe
//
//  Created by Justin Ji on 01/11/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit
import Firebase

extension APIService
{
    func sendEnquery(withEmail email: String, withEnquery enquery: String, completionHandler completion: @escaping (String) -> Void) {
        
         guard let memberIdx = UserDefaults.standard.object(forKey: "indexNumber") as? String else { return }
        
        let url = URL(string: baseURL+"/customer/mail")
        let postString = "member_idx=\(memberIdx)&email=\(email)&content=\(enquery)"
        
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
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
            
                    completion(json["return"] as! String)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func sendRequestBook(withTony tonyName:String, withAddress address:String, completionHandler completion: @escaping (String) -> Void)
    {
        guard let memberIdx = UserDefaults.standard.object(forKey: "indexNumber") as? String else { return }
        
        let url = URL(string:baseURL+"/customer/give_me_book")
        let postString = "member_idx=\(memberIdx)$tony_name=\(tonyName)$address=\(address)";
        
        guard let token = Messaging.messaging().fcmToken else { return }
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        request.addValue("gh_mobile{\(token)}", forHTTPHeaderField: "User-Agent")
        
        URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            if error != nil
            {
                print(error!)
                return
            }
            else
            {
                do
                {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                    completion(json["return"] as! String)
                }
                catch
                {
                    print(error)
                }
            }
        }.resume()
    }
}
