//
//  FetchCategories.swift
//  LeanOnMe
//
//  Created by Justin Ji on 02/11/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit
import Firebase

extension APIService {
    
    typealias completionForCategories = (String, [String]) -> Void
    func fetchCategories(CompletionHandler completion: @escaping (completionForCategories)) {
        
        let url = URL(string: baseURL+"/back/select_category")
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
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                    
                    var categoryArray = [String]()
                    var selectedCategory: String?
                    let categories = json["category"]
                    let valueArray = json["color"]
                    var idx = 0
                    for each in (valueArray as? [String])! {
                        if each == "true" {
                            selectedCategory = String(idx)
                        } else {
                            idx += 1
                        }
                    }
                    
                    for each in (categories as? [String])! {
                        categoryArray.append(each)
                    }
        
        
                    DispatchQueue.main.async {
                        completion(selectedCategory!, categoryArray)
                    }
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
}
