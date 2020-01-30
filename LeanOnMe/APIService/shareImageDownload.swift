//
//  shareImageDownload.swift
//  LeanOnMe
//
//  Created by Justin Ji on 03/11/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit
import Firebase

extension APIService {
    
    func shareImageDownload(withIdx idx: String, CompletionHandler completion: @escaping (String) -> Void) {
            
        let url = URL(string: baseURL+"/fun/imgDownload/\(idx)")
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
                    
                    let imageURL = json["image"] as! NSArray
                    
                    DispatchQueue.main.async {
                        completion(imageURL.firstObject as! String)
                    }
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
    func downloadImage(withImageName name: String, CompletionHandler completion: @escaping (String) -> Void) {
        
        let url = URL(string: baseURL+"/public/uploads/mobile/image/\(name)")
        
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
//                    DispatchQueue.main.async {
//                        completion(imageURL.firstObject as! String)
//                    }
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
}
