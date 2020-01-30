//
//  WebViewDelegateForNewPage.swift
//  LeanOnMe
//
//  Created by Justin Ji on 27/12/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit
import WebKit

extension NewPageViewController: WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    
    //MARK: 브릿지 잡고 처리하는 함수
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let scriptTitle = message.name
        switch scriptTitle {
        case "dot":
            let scriptMessage = message.body as?  [String]
            handleDot(scriptMessage: scriptMessage!)
        case "share":
            APIService.instance.shareImageDownload(withIdx: selectedIdx!, CompletionHandler: { (result) in
                self.imageName = result
                self.isSwitched = false
                self.downloadShareView.reloadData()
                self.showPopUpView()
            })
        case "update": print(message.body)
        case "updatee":
            let scriptMessage = message.body as?  String
            handleUpdatee(scriptMessage: scriptMessage!)
        case "updateee":
            let scriptMessage = message.body as?  String
            handleUpdateee(scriptMessage: scriptMessage!)
        case "keyboardup": webView.evaluateJavaScript("ioskeyboard()", completionHandler: nil)
        case "out": handleOut()
        default: break
        }
        
    }
    
    
    //MARK: 자바스크립트 경고창 세팅
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            completionHandler()
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) {
            action in completionHandler(false)
        }
        let okAction = UIAlertAction(title: "확인", style: .default) {
            action in completionHandler(true)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
        let alertController = UIAlertController(title: nil, message: prompt, preferredStyle: .actionSheet)
        
        alertController.addTextField { (textField) in
            textField.text = defaultText
        }
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            if let text = alertController.textFields?.first?.text {
                completionHandler(text)
            } else {
                completionHandler(defaultText)
            }
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            
            completionHandler(nil)
            
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
