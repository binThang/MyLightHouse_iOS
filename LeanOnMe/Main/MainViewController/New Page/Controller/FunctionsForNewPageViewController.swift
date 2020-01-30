//
//  FunctionsForNewPageViewController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 07/11/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit
import WebKit
import Firebase

extension NewPageViewController {
    //MARK: 스와이핑 함수들
    func swipeLeftAndRight() {
        let rightSwipeGeusture = UISwipeGestureRecognizer(target: self, action: #selector(handleRightSwipe(gesture:)))
        rightSwipeGeusture.direction = [.right]
        self.view.addGestureRecognizer(rightSwipeGeusture)
        
        let leftSwipeGeusture = UISwipeGestureRecognizer(target: self, action: #selector(handleLeftSwipe(gesture:)))
        
        leftSwipeGeusture.direction = [.left]
        self.view.addGestureRecognizer(leftSwipeGeusture)
    }
    
    //MARK: WebView and Controller Configuration
    func setupWebView() {
        let controller = WKUserContentController()
        controller.add(self, name: "dot")
        controller.add(self, name: "share")
        controller.add(self, name: "update")
        controller.add(self, name: "updatee")
        controller.add(self, name: "updateee")
        controller.add(self, name: "selectpic")
        controller.add(self, name: "sajin")
        controller.add(self, name: "out")
        
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        preferences.javaScriptEnabled = true
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.userContentController = controller
        
        let guestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(handleWebView(gesture:)))
        guestureRecogniser.numberOfTapsRequired = 1
        webView.addGestureRecognizer(guestureRecogniser)
        webView.isUserInteractionEnabled = true
        
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 63) , configuration: configuration)
        guard let token = Messaging.messaging().fcmToken else { return }
        webView.customUserAgent = "iPhone gh_mobile{\(token)}"
        webView.load(URLRequest(url: newPageURL!))
    }
    
    func setupContraints() {
        view.addSubview(webView)
        view.addSubview(dimmedView)
        view.addSubview(downloadShareView)
        view.addSubview(commentViewController.view)
        
        downloadShareView.register(PopUpViewCell.self, forCellWithReuseIdentifier: "cellId")
        downloadShareView.frame = CGRect(x: 70, y: view.frame.height + 10, width: view.frame.width - 140, height: 0)
        dimmedView.frame = view.frame
        dimmedView.alpha = 0
        
              
        
        
        NSLayoutConstraint.activate([
            commentViewController.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            commentViewController.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            commentViewController.view.widthAnchor.constraint(equalToConstant: 222),
            commentViewController.view.heightAnchor.constraint(equalToConstant: 134)
            ])
        commentViewController.view.alpha = 0
    }
    
    func showPopUpView() {

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.dimmedView.alpha = 0.8
            self.downloadShareView.alpha = 1
            self.downloadShareView.frame = CGRect(x: 70, y: 300, width: self.view.frame.width - 140, height: 100)
        }, completion: nil)
    }
    
    func displayShareSheet(withContent content: UIImage) {
        let acitvityViewController = UIActivityViewController(activityItems: [content as UIImage], applicationActivities: nil)
        present(acitvityViewController, animated: true, completion: nil)
    }
    
    func setupNavigationItemTitle() {
        
        switch listIdx {
        case "1"?: setupBackButtonTitle(withNavigationController: navigationController!, withTitle: "내 등에 기대")
        case "2"?:
            setupBackButtonTitle(withNavigationController: navigationController!, withTitle: "내 등에 기대")
        case "3"?:
            setupBackButtonTitle(withNavigationController: navigationController!, withTitle: "뻔해도 좋은")
        case "4"?:
            setupBackButtonTitle(withNavigationController: navigationController!, withTitle: "나의 다이어리")
        default: return
        }
        
        if(newPageURL?.absoluteString.contains("metoo"))!
        {
            setupBackButtonTitle(withNavigationController: navigationController!, withTitle: "나도 그래")
        }
    }
    
    func showCommentView() {
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.dimmedView.alpha = 1
            self.commentViewController.view.alpha = 1
            self.commentViewController.commentTextView.becomeFirstResponder()
        }, completion: nil)
    }
    
    func handleDot(scriptMessage: [String]) {
//        categoryIdx = scriptMessage[2] //3번째 오는 수가 카테고리 숫자이다.
//        //헤쉬태그 이름을
//        APIService.instance.fetchCategories { (selectedHastagIdx, result ) in
//            self.categoryArray = result
//            self.hashTagTitle = self.categoryArray[Int(self.categoryIdx!)! - 1]
//        }
        self.hashTagTitle = scriptMessage[2];
        
        if scriptMessage.first! == "me" {
            navigationItem.rightBarButtonItem = editDeleteButton
            isSwitched = true
        }
    }
    
    func handleUpdatee(scriptMessage: String) {
        commentIdx = scriptMessage
        isForComment = true
        downloadShareView.reloadData()
        self.showPopUpView()
    }
    
    func handleUpdateee(scriptMessage: String) {
        commentOfCommentIdx = scriptMessage
        isForCommentOfComment = true
        downloadShareView.reloadData()
        self.showPopUpView()
    }
    
    func setupSearchedTitle() {
        if let titleSearched = searchedTitle {
            setupBackButtonTitle(withNavigationController: navigationController!, withTitle: titleSearched)
        } else {
            setupNavigationItemTitle()
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
   
    
}




































































