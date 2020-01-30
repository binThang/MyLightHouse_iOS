//
//  MetorsHelpersViewController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 01/11/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit
import WebKit
import Firebase

class MetorsHelpersViewController: UIViewController {
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = true
        webView.allowsLinkPreview = true
        webView.backgroundColor = .white
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavitationItemTitle(navigationController: navigationController!, navigationItem: navigationItem, title: "멘토/도움주신분들")
        view.backgroundColor = .white
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        guard let token = Messaging.messaging().fcmToken else { return }
        webView.customUserAgent = "iPhone gh_mobile{\(token)}"
        
        APIService.instance.fetchMentorsHelpersImage { (img) in
            let url = URL(string: baseURL+"/public/uploads/mobile/image/" + img)
            DispatchQueue.main.async {
                self.webView.load(URLRequest(url: url!))
            }

        }
    
    }


   
    

}






















































