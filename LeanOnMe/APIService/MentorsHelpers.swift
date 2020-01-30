//
//  MentorsHelpers.swift
//  LeanOnMe
//
//  Created by Justin Ji on 01/11/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension APIService {
    
    func fetchMentorsHelpersImage(completionHandler completion: @escaping (String) -> Void) {
        
        let url = URL(string: baseURL+"/customer/select_heppeople")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("gh_mobile{}", forHTTPHeaderField: "User-Agent")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                    
                    print(json)
                    completion(json["img"] as! String)
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
    
}
