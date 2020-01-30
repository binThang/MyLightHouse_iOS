//
//  Deregistration.swift
//  LeanOnMe
//
//  Created by Justin Ji on 01/11/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension APIService {
    
    func deregirstration(withMemberIdx memberIdx: String, completionHandler completion: @escaping (String) -> Void) {
        
        let url = URL(string: baseURL + "/withdrawal")
        let postString = "member_idx=\(memberIdx)"
        
        
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
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                    
                    DispatchQueue.main.async {
                        completion(json["return"] as! String)
                    }
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
}
