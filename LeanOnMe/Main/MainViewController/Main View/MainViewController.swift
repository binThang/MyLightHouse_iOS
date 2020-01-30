//
//  MainViewController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 26/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit
import WebKit
import Firebase

protocol MainViewVCDelegate {
    func WillGoBack(isFromNewPage: Bool)
    func willGoBackHome(isFromNewPage: Bool, idx: String)
    func willGoBackWithURLToLoad(isTriggerredByNotification: Bool, urlToLoad: URL)
    func willComeBackFromSearchedResultView(isFrom: Bool)
}

class MainViewController: UIViewController, UISearchBarDelegate {
    
    
    let baseURLStr = baseURL+"/back/list"
    var lBaseURL: URL {
        get {
            return URL(string: self.baseURLStr + "/\(listIdx ?? "1")/\(selectedIdx ?? "1")")!
        }
    }
    
    
    var nickname: String?
    var isSwitched: Bool = false
    var isHashTagSelected: Bool = false
    var categoryArray = [String]()
    var selectedHashTag = "1"
    var selectedHashTagTitle: String?
    var selectedIdx: String?
    var listIdx: String? //내가 어떤 페이지에 있는지 알려주는 변수
    var isFromNewPage: Bool?
    var isTriggerredByNotification: Bool?
    var urlToLoad: URL?
    var searchedTitle: String?
    var isFromSearchedResultView: Bool?
    
    lazy var sideMenuButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "hamburger"), for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var previousButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "prev"), for: .normal)
        button.backgroundColor = .white
        button.alpha = 0
        button.addTarget(self, action: #selector(handlePrevButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var previousForSeach: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "prev"), for: .normal)
        button.backgroundColor = .white
        button.alpha = 0
        button.addTarget(self, action: #selector(handlePrevForSearch), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("✕", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("나누기", for: .normal)
        button.setTitleColor(UIColor.init(hexString: "fda119"), for: .normal)
        button.titleLabel?.font = komaconFont(17)
        button.backgroundColor = .white
        button.alpha = 0
        button.addTarget(self, action: #selector(handleComplete), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var searchBar: UITextField = {
        let searchBar = UITextField()
        searchBar.alpha = 0
        searchBar.placeholder = "검색"
        searchBar.font = notoSansUIRegular(13)
        let searchImageView = UIImageView(image: #imageLiteral(resourceName: "main_search"))
        searchImageView.frame = CGRect(x: 30, y: 0, width: 25, height: 25)
        searchBar.leftView = searchImageView
        searchBar.leftViewMode = .always
        searchBar.layer.borderColor = UIColor.black.cgColor
        searchBar.layer.borderWidth = 1
        searchBar.layer.cornerRadius = 5
        searchBar.layer.masksToBounds = true
        searchBar.addTarget(self, action: #selector(handleSearchBar), for: .editingDidBegin)
        searchBar.addTarget(self, action: #selector(handleSearchBar), for: .editingChanged)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "main_search"), for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        return button
    }()
    
    let mainLogo: UILabel = {
        let label = UILabel()
        label.text = "내 등에 기대"
        label.textAlignment = .center
        label.font =  yacheFont(20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let resultTitle: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.textAlignment = .left
        label.font =  yacheFont(20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let hashTagLabel: UILabel = {
        let label = UILabel()
        label.text = "친구"
        label.textAlignment = .center
        label.font = notoSansUIRegular(21)
        label.alpha = 0
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleHashTagLabel)))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var hashTagButton: UIButton = {
        let button = UIButton()
        button.alpha = 0
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
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.isUserInteractionEnabled = true
        webView.allowsBackForwardNavigationGestures = false
        return webView
    }()
    
  

    lazy var sideMenuLauncher: SideMenuLauncher = {
        let launcher = SideMenuLauncher()
        launcher.signOutButton.addTarget(self, action: #selector(handleSignOut), for: .touchUpInside)
        launcher.deregistrationButton.addTarget(self, action: #selector(handleDeregistration), for: .touchUpInside)
        launcher.mainViewController = self
        return launcher
    }()
    
    lazy var floatingButton: FloatingButtonView = {
        let view = FloatingButtonView()
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.alpha = 0.6
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleFloatingButton)))
        return view
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
    
    lazy var deleteSearchTermsButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "search_delete"), for: .normal)
        button.alpha = 0
        button.addTarget(self, action: #selector(handleDeleteSearchTerms), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        view.backgroundColor = .white
        fetchNotificatioins()
        sendMemberIdx()
        setupNavigationBar()
        setupSideMenu()
        setupWebView()

        APIService.instance.sendiOSToken { (result) in
        }
        
        UIApplication.shared.registerForRemoteNotifications()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        checkToShowFloatingButton()
        checkWhereToGetBack()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        checkToShowFloatingButton()
        checkWhereToGetBack()
    }
    
    func checkToShowFloatingButton() {
        
        if let isfrom = isFromSearchedResultView {
            if isfrom {
                floatingButton.alpha = 0
                isFromSearchedResultView = nil
            } else {
                floatingButton.alpha = 0.7
                isFromSearchedResultView = nil
            }
        }
    }
    
    func checkWhereToGetBack() {
        
        if isFromNewPage != nil {
            if isFromNewPage! {
                guard let idx = selectedIdx else { return }
                mainWebView.evaluateJavaScript("reload(\(idx))", completionHandler: nil)
                mainWebView.evaluateJavaScript("reload_update(\(idx))", completionHandler: nil)
            } else {
                mainWebView.reload()
            }
        } else {
            mainWebView.reload()
        }
    }
}


extension MainViewController: MainViewVCDelegate, UIScrollViewDelegate {
    
    func willComeBackFromSearchedResultView(isFrom: Bool) {
        isFromSearchedResultView = isFrom
    }
    
    func willGoBackWithURLToLoad(isTriggerredByNotification: Bool, urlToLoad: URL) {
        self.isTriggerredByNotification = isTriggerredByNotification
        self.urlToLoad = urlToLoad
    }
    
    func willGoBackHome(isFromNewPage: Bool, idx: String) {
        self.isFromNewPage = isFromNewPage
        self.selectedIdx = idx
    }
    
    func WillGoBack(isFromNewPage: Bool) {

        self.isFromNewPage = isFromNewPage
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x > 0 {
            scrollView.contentOffset = CGPoint(x: 0, y: scrollView.contentOffset.y)
        }
    }
}


















































