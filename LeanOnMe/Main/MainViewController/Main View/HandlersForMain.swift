//
//  HandlersForMain.swift
//  LeanOnMe
//
//  Created by Justin Ji on 02/11/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit
import WebKit
import Firebase

extension MainViewController {
    
    func setupWebView() {
        let controller = WKUserContentController()
        controller.add(self, name: "newpage")
        controller.add(self, name: "funlist")
        controller.add(self, name: "writea")
        controller.add(self, name: "selectpic")
        controller.add(self, name: "sajin")
        controller.add(self, name: "out")
        controller.add(self, name: "sname")
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = controller
        
        let rightSwipeGeusture = UISwipeGestureRecognizer(target: self, action: #selector(handleRightSwipe(gesture:)))
        rightSwipeGeusture.direction = [.right]
        self.view.addGestureRecognizer(rightSwipeGeusture)
        
        let leftSwipeGeusture = UISwipeGestureRecognizer(target: self, action: #selector(handleLeftSwipe(gesture:)))
        
        leftSwipeGeusture.direction = [.left]
        self.view.addGestureRecognizer(leftSwipeGeusture)

        mainWebView = WKWebView(frame: CGRect(x: 0, y: 75, width: view.frame.width, height: view.frame.height - 75), configuration: configuration)

        guard let token = Messaging.messaging().fcmToken else { return }
        mainWebView.customUserAgent = "iPhone gh_mobile{\(token)}"
        mainWebView.load(URLRequest(url: lBaseURL))
        view.addSubview(mainWebView)
        floatingButton.alpha = 0.7
        setupComponents()
        
    }
    func setupNavigationBar() {
        UIApplication.shared.statusBarStyle = .default
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func sendMemberIdx() {
        guard let memberIdx = UserDefaults.standard.object(forKey: "indexNumber") as? String else { return }
        
        APIService.instance.fetchMyInfo(withMemberIdx: memberIdx) { (nickname) in
            self.nickname = nickname
        }
    }
    
    func setupSideMenu() {
        if isSwitched {
            sideMenuButton.addTarget(self, action: #selector(handlePrevButton), for: .touchUpInside)
        } else {
            sideMenuButton.addTarget(self, action: #selector(handleSideMenuButton), for: .touchUpInside)
        }
    }
    //FCM푸시 잡는 함수
    func fetchNotificatioins() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleFetchFCM(notification:)), name: Notification.Name("background"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleFetchFCM(notification:)), name: Notification.Name("foreground"), object: nil)

    }
    

    
    @objc func handleFetchFCM(notification: Notification) {
   
        let urlStr = baseURL+"/"
        guard let linkURL = notification.userInfo!["url"] as? String else { return }
        guard let idx = notification.userInfo!["idx"] as? String else { return }
        guard let url = URL(string: urlStr + linkURL) else { return }
        let newPageVC = NewPageViewController()
        newPageVC.newPageURL = url
        newPageVC.selectedIdx = idx
        navigationController?.pushViewController(newPageVC, animated: true)
    }
    
    func showMainWhenNotificationIsReceived() {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.previousButton.alpha = 1
            self.mainLogo.alpha = 1
            self.hashTagLabel.alpha = 0
            self.completeButton.alpha = 0
            self.hashTagButton.alpha = 0
            self.floatingButton.alpha = 0
            self.sideMenuButton.alpha = 0
            self.searchButton.alpha = 0
            self.cancelButton.alpha = 0
        }, completion: nil)
    }
    
    
    
    @objc func handleRightSwipe(gesture: UISwipeGestureRecognizer) {
        
        mainWebView.evaluateJavaScript("prev()", completionHandler: nil)
    }
    
    @objc func handleLeftSwipe(gesture: UISwipeGestureRecognizer) {
        
        mainWebView.evaluateJavaScript("next()", completionHandler: nil)
    }
    
    @objc func handleFloatingButton() {
        APIService.instance.fetchCategories { (selectedHashTagIdx, result ) in
            self.categoryArray = result
            self.selectedHashTagTitle = self.categoryArray[Int(selectedHashTagIdx)!]
            self.hashTagLabel.text = self.selectedHashTagTitle
        }
        
        let url: URL
        
        if listIdx == "2" {
            url = URL(string: baseURL+"/back/tony")!
        } else {
            url = URL(string: baseURL+"/back/write")!
        }
        
        mainWebView.load(URLRequest(url: url))
        mainWebView.scrollView.bounces = false
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.previousButton.alpha = 1
            self.hashTagLabel.alpha = 1
            self.completeButton.alpha = 1
            self.hashTagButton.alpha = 1
            self.floatingButton.alpha = 0
            self.sideMenuButton.alpha = 0
            self.searchButton.alpha = 0
            self.cancelButton.alpha = 0
            self.mainLogo.alpha = 0
        }, completion: nil)
    }
    
    @objc func handlePrevButton() {
 
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.floatingButton.alpha = 0.7
            self.searchButton.alpha = 1
            self.mainLogo.alpha = 1
            self.sideMenuButton.alpha = 1
            self.previousButton.alpha = 0
            self.cancelButton.alpha = 0
            self.hashTagLabel.alpha = 0
            self.hashTagButton.alpha = 0
            self.completeButton.alpha = 0
            self.searchBar.alpha = 0
            self.collectionView.alpha = 0
            self.deleteSearchTermsButton.alpha = 0
        }, completion: nil)
        
   
        view.endEditing(true)
        selectedIdx = "1"
        mainWebView.load(URLRequest(url: lBaseURL))
        isFromSearchedResultView = false
        searchedTitle = nil
        if categoryArray.count > 0 {
            hashTagLabel.text = categoryArray[0]
        }
        mainWebView.scrollView.isScrollEnabled = true
    }
    
    func setUpCollectionView() {
        view.addSubview(border)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            border.topAnchor.constraint(equalTo: hashTagLabel.bottomAnchor, constant: 9),
            border.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            border.widthAnchor.constraint(equalToConstant: view.frame.width - 38),
            border.heightAnchor.constraint(equalToConstant: 1),
            
            collectionView.topAnchor.constraint(equalTo: border.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        collectionView.register(HashTagViewCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.contentInset = UIEdgeInsets(top: 18, left: 0, bottom: 0, right: 0)
    }
    
    @objc func handleHashTagLabel() {
        
        if isHashTagSelected {
            hashTagButton.setBackgroundImage(#imageLiteral(resourceName: "down"), for: .normal)
            isHashTagSelected = false
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.collectionView.alpha = 0
                self.cancelButton.alpha = 0
                self.border.alpha = 0
                self.completeButton.alpha = 1
                self.previousButton.alpha = 1
            }, completion: nil)
            collectionView.removeFromSuperview()
        } else {
            setUpCollectionView()
            hashTagButton.setBackgroundImage(#imageLiteral(resourceName: "up"), for: .normal)
            isHashTagSelected = true
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.previousButton.alpha = 0
                self.collectionView.alpha = 1
                self.border.alpha = 1
                self.cancelButton.alpha = 1
                self.completeButton.alpha = 0
            }, completion: nil)
        }
    }
    
    @objc func handleCancelButton() {
        handleHashTagLabel()
    }
    
    @objc func handleComplete() {
        mainWebView.evaluateJavaScript("insert_board(\(selectedHashTag))") { (any, error) in
            self.handlePrevButton()
        }
    }
    
    //MARK: Search
    @objc func handleSearch() {
        UIView.animate(withDuration: 0.2) {
            self.deleteSearchTermsButton.alpha = 1
            self.previousButton.alpha = 1
            self.searchButton.alpha = 0
            self.searchBar.alpha = 1
            self.mainLogo.alpha = 0
            self.floatingButton.alpha = 0
        }
        searchBar.becomeFirstResponder()
        let searchURL = URL(string: baseURL+"/search")
        mainWebView.load(URLRequest(url: searchURL!))

    }
   
    @objc func handleSearchBar() {
        
        guard let searchedTerm = searchBar.text else { return }

        if searchedTerm.isEmpty {
            mainWebView.evaluateJavaScript("nosearch()", completionHandler: nil)
            let searchURL = URL(string: baseURL+"/search")
            mainWebView.load(URLRequest(url: searchURL!))
        } else {
            mainWebView.evaluateJavaScript("search('\(searchedTerm)')", completionHandler: nil)
        }
    }
    
    //MARK: Deregistration
    @objc func handleDeregistration() {
        
        guard let memberIdx = UserDefaults.standard.object(forKey: "indexNumber") as? String else { return }
        
        sideMenuLauncher.handleDismiss()
        let alert = UIAlertController(title: "회원탈퇴", message: "정말 회원탈퇴를 하시겠습까?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "예", style: .default) { (action) in
            
            
            APIService.instance.deregirstration(withMemberIdx: memberIdx, completionHandler: { (result) in
                
                if result == "true" {
                    let logInViewController = LogInController()
                    self.navigationController?.pushViewController(logInViewController, animated: true)
                } else {
                    
                }
            })
        }
        
        let noAction = UIAlertAction(title: "아니요", style: .cancel, handler: nil)
        
        alert.addAction(noAction)
        alert.addAction(yesAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    @objc func handleSignOut() {
        
        sideMenuLauncher.handleDismiss()
        
        let alert = UIAlertController(title: "로그아웃", message: "로그아웃을 하시겠습니까?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "예", style: .default) { (finished) in
            
            
            UserDefaults.standard.set(false, forKey: "isSignedIn")
            UserDefaults.standard.synchronize()
            
            APIService.instance.logOut(completionHandler: { (result) in
                if result == "true" {
                    let logInViewController = LogInController()
                    self.navigationController?.pushViewController(logInViewController, animated: true)
                }
            })
        }
        
        let noAction = UIAlertAction(title: "아니요", style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
    }
    
    //사이드 메뉴를 보여주는 함수
    @objc func handleSideMenuButton() {
        
        let width = Int(estimateFrameForText(text: nickname!).width) + 15
        sideMenuLauncher.showSideMenu(WithNickname: nickname!, withWidth: width)

    }
    
  
    
    
    //SideMenuView의 collectionView에서 선택된 셀 아이템을 해당하는 되는 UIViewController로 보내주는 함수
    func showControllerForItem(withMenuItem menuItem: MenuItem) {

        if menuItem.title == "설정" {
            floatingButton.isHidden = false
            
            let settingsViewController = SettingsViewController()
        navigationController?.pushViewController(settingsViewController, animated: true)
        } else if menuItem.title == "내 등에 기대" {
            floatingButton.isHidden = false
            let url = URL(string: baseURL+"/back/list/1/1")
            mainLogo.text = "내 등에 기대"
            mainWebView.load(URLRequest(url: url!))
        } else if menuItem.title == "나도 그래" {
            floatingButton.isHidden = false
            let url = URL(string: baseURL+"/metoo/list/1/1")
            mainLogo.text = "나도 그래"
            mainWebView.load(URLRequest(url: url!))
        } else if menuItem.title == "뻔해도 좋은" {
            floatingButton.isHidden = false
            let url = URL(string: baseURL+"/fun/list2/1")
            mainLogo.text = "뻔해도 좋은"
            floatingButton.isHidden = true
            mainWebView.load(URLRequest(url: url!))
        } else if menuItem.title == "나의 다이어리" {
            floatingButton.isHidden = true
            let url = URL(string: baseURL+"/diary/list/1")
            mainLogo.text = "나의 다이어리"
            mainWebView.load(URLRequest(url: url!))
        }
    }
    
    @objc func handleDeleteSearchTerms() {
        searchBar.text = ""
        mainWebView.evaluateJavaScript("nosearch()", completionHandler: nil)
        let searchURL = URL(string: baseURL+"/search")
        mainWebView.load(URLRequest(url: searchURL!))
    }
    
    @objc func handleGetBackToWrite() {
        handleFloatingButton()
        UIView.animate(withDuration: 0.3, animations: {
            self.disappearPicturesButton.alpha = 0
        })
    }
    func navigateToNewPage(dataArray: [String]) {
        
        let url = dataArray[0]
        let alternativeIdx = url.split(separator: "/")[2]
        let swipingIdx: String?
        let newPageURL: URL?
        
        if dataArray[2].isEmpty {
            selectedIdx = String(alternativeIdx)
            newPageURL = URL(string: baseURL+dataArray[0])
        } else {
            if !dataArray[3].isEmpty {
                swipingIdx = dataArray[3]
            } else {
                swipingIdx = ""
            }
            selectedIdx = dataArray[2]
            newPageURL = URL(string: baseURL+dataArray[0] + "/" + swipingIdx!)
        }
        
        let newPageViewController = NewPageViewController()
        if let titleSearched = searchedTitle {
            newPageViewController.searchedTitle = titleSearched
            searchedTitle = nil
            newPageViewController.isFromSearchedView = true
        } else {
            
            searchedTitle = nil
        }
        
        newPageViewController.selectedIdx = selectedIdx!
        newPageViewController.listIdx = listIdx
        newPageViewController.newPageURL = newPageURL!
        newPageViewController.delegate = self
        newPageViewController.editMyPostVC.delegate = self
        navigationController?.pushViewController(newPageViewController, animated: true)
    
    }
    
    
    func showPics() {
        UIView.animate(withDuration: 0.3, animations: {
            self.previousButton.alpha = 0
            self.hashTagLabel.alpha = 0
            self.hashTagButton.alpha = 0
            self.completeButton.alpha = 0
            self.disappearPicturesButton.alpha = 1
        })
    }
    func selectPic() {
        UIView.animate(withDuration: 0.3, animations: {
            self.previousButton.alpha = 1
            self.hashTagLabel.alpha = 1
            self.hashTagButton.alpha = 1
            self.completeButton.alpha = 1
            self.disappearPicturesButton.alpha = 0
        })
    }
    
    func hideAllButtonExceptDeleteOne() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.floatingButton.alpha = 0
            self.sideMenuButton.alpha = 0
            self.searchBar.alpha = 1
            self.previousButton.alpha = 1
            self.mainLogo.alpha = 0
            self.searchButton.alpha = 0
            self.deleteSearchTermsButton.alpha = 1
        }, completion: nil)
        searchBar.text = ""
    }
    
    func refreshMainWebView(withIdx idx: String) {
        handleHashTagLabel()
        let idxNum = Int(idx)!
        
        selectedHashTag = String(idxNum)
        mainWebView.evaluateJavaScript("select_hashtag(\(idxNum))") { (success, error) in
            self.hashTagLabel.text =  self.categoryArray[idxNum - 1] //위에 해쉬태그 라벨에 이름을 변경해준다.
            self.selectedHashTag = String(idxNum)//자바스트립트 함수에 넣어줘야 해서 글로벌 변수에다가 값을 준다.
        }
        
    }
    
    func handleShowResults(title: String) {
        resultTitle.text = title
        UIView.animate(withDuration: 0.2) {
            self.previousButton.alpha = 0
            self.previousForSeach.alpha = 1
            self.resultTitle.alpha = 1
            self.searchBar.alpha = 0
            self.searchButton.alpha = 0
            self.deleteSearchTermsButton.alpha = 0
        }
    }
    
    @objc func handlePrevForSearch() {
        mainWebView.goBack()
        UIView.animate(withDuration: 0.2) {
            self.previousButton.alpha = 1
            self.previousForSeach.alpha = 0
            self.resultTitle.alpha = 0
            self.searchBar.alpha = 1
            self.deleteSearchTermsButton.alpha = 1
            self.floatingButton.alpha = 0
        }
    }
    
}



























































