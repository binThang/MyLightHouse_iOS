//
//  DeletePost.swift
//  LeanOnMe
//
//  Created by Justin Ji on 06/11/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension APIService {
    
    
    func deletePost(withIdx idx: String, completion: @escaping (String) -> Void) {
        
        let url = URL(string: baseURL+"/back/del_board")
        let postString = "board_idx=\(idx)"
    
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
                    
                    
                    DispatchQueue.main.async {
                        completion(json!["result"] as! String)
                    }
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
}
