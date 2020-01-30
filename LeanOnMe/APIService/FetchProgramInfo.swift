//
//  FetchProgramInfo.swift
//  LeanOnMe
//
//  Created by Justin Ji on 06/11/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension APIService {
    
    
    func fetchAgreement(completion: @escaping (String) -> Void) {
        
        let url = URL(string: baseURL+"/agree/agree1")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("gh_mobile{}", forHTTPHeaderField: "User-Agent")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: AnyObject]

                    DispatchQueue.main.async {
                        completion(json!["agree"] as! String)
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func fetchPrivacy(completion: @escaping (String) -> Void) {
        
        let url = URL(string: baseURL+"/agree/agree2")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("gh_mobile{}", forHTTPHeaderField: "User-Agent")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: AnyObject]
                    
                    DispatchQueue.main.async {
                        completion(json!["agree"] as! String)
                    }
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
}
