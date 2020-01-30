//
//  FetchAnnouncement.swift
//  LeanOnMe
//
//  Created by Justin Ji on 06/11/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension APIService {
    
    func fetchAnnouncement(completion: @escaping ([Section]) -> Void) {
        
        let url = URL(string: baseURL+"/customer/select_notice")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("gh_mobile{}", forHTTPHeaderField: "User-Agent")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            } else {
                do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[String: AnyObject]]
                    
                    var sectionArray = [Section]()
                    
                    for each in json! {
                        let section = Section(title: each["title"] as! String, subtitle: each["wdate"] as! String, content: each["content"] as! [String], isExpanded: false)
                        sectionArray.append(section)
                    }
                    
                    DispatchQueue.main.async {
                        completion(sectionArray)
                    }
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
}
