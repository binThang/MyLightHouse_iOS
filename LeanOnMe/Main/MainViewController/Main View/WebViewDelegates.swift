//
//  WebViewDelegates.swift
//  LeanOnMe
//
//  Created by Justin Ji on 15/12/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit
import WebKit

extension MainViewController: WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let otherAction = UIAlertAction(title: "확인", style: .default) {
            action in completionHandler()
        }
        alertController.addAction(otherAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        
        switch message.name {
        case "funlist":
            let scriptMessage = message.body as? String
            listIdx = scriptMessage

        case "newpage":
            guard let scriptMessage = message.body as? [String] else { return }
            navigateToNewPage(dataArray: scriptMessage)
        case "sajin": showPics()
        case "selectpic": selectPic()
        case "out": handleOut()
        case "sname":
            
            guard let searchedTerm = searchBar.text else { return }
            var searchedWords: String?
            if searchedTerm.isEmpty {
                guard let term = message.body as? String else { return }
                searchedWords = term
            } else {
                searchedWords = searchedTerm
            }
            
            searchedTitle = searchedWords
            handleShowResults(title: searchedWords!)
        default: break
        }
        
    }
    
    func handleOut() {
        let alert = UIAlertController(title: "로그인 중복", message: "다른 기기에서 로그인이 되어 로그아웃 됩니다.", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: { (_) in
            let logInViewController = LogInController()
            self.navigationController?.pushViewController(logInViewController, animated: true)
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        if webView.url?.absoluteString == baseURL+"/search" {
            hideAllButtonExceptDeleteOne()
        }
        
    }
}






















































