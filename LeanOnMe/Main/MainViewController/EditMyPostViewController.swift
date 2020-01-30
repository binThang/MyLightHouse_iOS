//
//  EditMyPostViewController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 19/12/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit
import WebKit
import Firebase

class EditMyPostViewController: UIViewController {

    let baseURLStr = baseURL+"/back/list/"
    var delegate: MainViewVCDelegate?
    
    var lBaseURL: URL {
        get {
            return URL(string: self.baseURLStr + "\(listIdx ?? "1")/\(selectedIdx ?? "1")")!
        }
    }
    
    
    var isHashTagSelected: Bool = false
    var categoryArray = [String]()
    var selectedHashTag = "1"
    var selectedHashTagTitle: String?
    var selectedIdx: String?
    var listIdx: String? //내가 어떤 페이지에 있는지 알려주는 변수

    var categoryIdx: String? //카테고리 idx
    var urlToLoad: URL?
    
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("✕", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var disappearHashTag: UIButton = {
        let button = UIButton()
        button.alpha = 0
        button.setTitle("✕", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleDisappearHashTag), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("나누기", for: .normal)
        button.setTitleColor(UIColor.init(hexString: "fda119"), for: .normal)
        button.titleLabel?.font = komaconFont(17)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleComplete), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let hashTagLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = komaconFont(21)
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleHashTagLabel)))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var hashTagButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "down"), for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleHashTagLabel), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var mainWebView: WKWebView = {
        let webView = WKWebView()
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsLinkPreview = true
        webView.scrollView.isScrollEnabled = true
        webView.allowsBackForwardNavigationGestures = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.isUserInteractionEnabled = true
        return webView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let border: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "313131")
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var disappearPicturesButton: UIButton = {
        let button = UIButton()
        button.alpha = 0
        button.setTitle("✕", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = notoSansUIRegular(25)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleGetBackToWrite), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupWebView()
        APIService.instance.fetchCategories { (selectedHastagIdx, result ) in 
            self.categoryArray = result
        }
    }
    
    
    func setupComponents() {
        view.addSubview(hashTagLabel)
        view.addSubview(hashTagButton)
        view.addSubview(cancelButton)
        view.addSubview(disappearHashTag)
        view.addSubview(completeButton)
        view.addSubview(mainWebView)
        view.addSubview(disappearPicturesButton)
        
        NSLayoutConstraint.activate([
            
            cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
            cancelButton.widthAnchor.constraint(equalToConstant: 39),
            cancelButton.heightAnchor.constraint(equalToConstant: 30),
            
            disappearHashTag.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
            disappearHashTag.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
            disappearHashTag.widthAnchor.constraint(equalToConstant: 39),
            disappearHashTag.heightAnchor.constraint(equalToConstant: 30),
            
            hashTagLabel.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor, constant: -2),
            hashTagLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hashTagLabel.widthAnchor.constraint(equalToConstant: 40),
            hashTagLabel.heightAnchor.constraint(equalToConstant: 34),
            
            hashTagButton.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor),
            hashTagButton.leadingAnchor.constraint(equalTo: hashTagLabel.trailingAnchor),
            hashTagButton.widthAnchor.constraint(equalToConstant: 30),
            hashTagButton.heightAnchor.constraint(equalToConstant: 30),
            
            completeButton.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor),
            completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
            completeButton.widthAnchor.constraint(equalToConstant: 50),
            completeButton.heightAnchor.constraint(equalToConstant: 15),
            
            mainWebView.topAnchor.constraint(equalTo: hashTagLabel.bottomAnchor, constant: 5),
            mainWebView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainWebView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainWebView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            disappearPicturesButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
            disappearPicturesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
            disappearPicturesButton.widthAnchor.constraint(equalToConstant: 39),
            disappearPicturesButton.heightAnchor.constraint(equalToConstant: 30),
            ])
    }
    
    func setupWebView() {
        let controller = WKUserContentController()
        controller.add(self, name: "writea")
        controller.add(self, name: "out")
        controller.add(self, name: "selectpic")
        controller.add(self, name: "sajin")
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = controller
        
        mainWebView = WKWebView(frame: CGRect(x: 0, y: 75, width: view.frame.width, height: view.frame.height - 75), configuration: configuration)
        
        
        guard let token = Messaging.messaging().fcmToken else { return }
        
        mainWebView.customUserAgent = "iPhone gh_mobile{\(token)}"
        mainWebView.load(URLRequest(url: urlToLoad!))
        view.addSubview(mainWebView)
        
        if let idx = Int(selectedIdx!), let cateIdx = Int(categoryIdx!) {
        
            mainWebView.evaluateJavaScript("select_hashtag_ck(\(cateIdx), \(idx))", completionHandler: { (any, error) in
                
            })
        }
        
        setupComponents()
    }
}

extension EditMyPostViewController: WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
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
        case "writea":
            let scriptMessage = message.body as? String
        case "out": handleOut()
        case "sajin": showPics()
        case "selectpic": selectPic()
        default: break
        }
        
    }
    
    func showPics() {
        UIView.animate(withDuration: 0.3, animations: {
            self.cancelButton.alpha = 0
            self.disappearHashTag.alpha = 0
            self.hashTagLabel.alpha = 0
            self.hashTagButton.alpha = 0
            self.completeButton.alpha = 0
            self.disappearPicturesButton.alpha = 1
        })
    }
    func selectPic() {
        UIView.animate(withDuration: 0.3, animations: {
            self.cancelButton.alpha = 1
            self.disappearHashTag.alpha = 1
            self.hashTagLabel.alpha = 1
            self.hashTagButton.alpha = 1
            self.completeButton.alpha = 1
            self.disappearPicturesButton.alpha = 0
        })
    }
    
    func handleOut() {
        let alert = UIAlertController(title: "로그인 중복", message: "다른 기기에서 로그인이 되어 로그아웃 됩니다.", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: { (_) in
            self.navigationController?.pushViewController(LogInController(), animated: true)
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func handleGetBackToWrite() {
        
        let url: URL
        if listIdx == "2" {
            url = URL(string: ""+baseURL+"/back/tony")!
        } else {
            url = URL(string: ""+baseURL+"/back/write")!
        }
        
        mainWebView.load(URLRequest(url: url))
        selectPic()
       
    }
    
}

extension EditMyPostViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! HashTagViewCell
        cell.nameLabel.text = categoryArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0: refreshMainWebView(withIdx: "1")
        case 1: refreshMainWebView(withIdx: "2")
        case 2: refreshMainWebView(withIdx: "3")
        case 3: refreshMainWebView(withIdx: "4")
        case 4: refreshMainWebView(withIdx: "5")
        case 5: refreshMainWebView(withIdx: "6")
        case 6: refreshMainWebView(withIdx: "7")
        case 7: refreshMainWebView(withIdx: "8")
        case 8: refreshMainWebView(withIdx: "9")
        case 9: refreshMainWebView(withIdx: "10")
        default:
            return
        }
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
    
    @objc func handleHashTagLabel() {
        
        if isHashTagSelected {
            hashTagButton.setBackgroundImage(#imageLiteral(resourceName: "down"), for: .normal)
            isHashTagSelected = false
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.disappearHashTag.alpha = 0
                self.collectionView.alpha = 0
                self.cancelButton.alpha = 1
                self.border.alpha = 0
                self.completeButton.alpha = 1
                
            }, completion: nil)
            collectionView.removeFromSuperview()
        } else {
            setUpCollectionView()
            hashTagButton.setBackgroundImage(#imageLiteral(resourceName: "up"), for: .normal)
            isHashTagSelected = true
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.disappearHashTag.alpha = 1
                self.collectionView.alpha = 1
                self.border.alpha = 1
                self.cancelButton.alpha = 0
                self.completeButton.alpha = 0
            }, completion: nil)
        }
    }
    
    func setUpCollectionView() {
        view.addSubview(border)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            border.topAnchor.constraint(equalTo: hashTagLabel.bottomAnchor, constant: 7),
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
    
}

extension EditMyPostViewController {
    
    @objc func handleCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleDisappearHashTag() {
        handleHashTagLabel()
    }
    
    @objc func handleComplete() {
        guard let postIdx =  selectedIdx else { return }
        
        mainWebView.evaluateJavaScript("update_board(\(selectedHashTag))") { (success, error) in
            self.delegate?.willGoBackHome(isFromNewPage: false, idx: postIdx)
            self.dismiss(animated: true, completion: nil)
        }
    }
}























































