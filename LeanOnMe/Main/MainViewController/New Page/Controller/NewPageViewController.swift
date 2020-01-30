//
//  NewPageViewController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 02/11/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit
import WebKit
import Firebase

class NewPageViewController: UIViewController, UITextFieldDelegate {
    
    let editMyPostVC = EditMyPostViewController()
    var listIdx: String?
    var categoryIdx: String? //카테고리 idx
    var commentIdx: String?
    var commentOfCommentIdx: String?
    var selectedIdx: String?
    var newPageURL: URL?
    var imageName: String?
    var isSwitched: Bool = false //false이면 자신의 글에서 글을 수정하거나 지울수 있게 팝업창을 보여주고 네비게이션 바에 있는 버튼을 바꿔준다.
    var isForComment: Bool = false //댓글의 수정하거나 지우기 위해서 창을 띄어준다.
    var isForCommentOfComment: Bool = false //댓글의 댓글을 수정하거나 지우기 위해서 창을 띄어준다.
    var searchedTitle: String?
    var isFromSearchedView: Bool?
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.uiDelegate = self
        webView.scrollView.isScrollEnabled = false
        webView.navigationDelegate = self
        webView.allowsLinkPreview = true
        webView.backgroundColor = .blue
        webView.allowsBackForwardNavigationGestures = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.isUserInteractionEnabled = true
        return webView
    }()
    
    lazy var downloadShareView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
       collectionView.layer.cornerRadius = 7
        return collectionView
    }()
    
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.8)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDimmedView)))
        return view
    }()
    
    lazy var editDeleteButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "more"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(handleEditDelete))
        
        return barButtonItem
    }()
    
    lazy var completeButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(handleComplete))
        return barButtonItem
    }()

    lazy var commentViewController: CommentViewController = {
        let commentVC = CommentViewController()
        commentVC.view.layer.cornerRadius = 17
        commentVC.view.layer.masksToBounds = true
        commentVC.view.translatesAutoresizingMaskIntoConstraints = false
        commentVC.completeButton.addTarget(self, action: #selector(handleCompleteButton), for: .touchUpInside)
        commentVC.cancelButton.addTarget(self, action: #selector(handleDimmedView), for: .touchUpInside)
        return commentVC
    }()
    
    let forDownloadShare: [DownloadShare] = [  DownloadShare(image: #imageLiteral(resourceName: "download"), title: "이미지 다운로드"),
           DownloadShare(image: #imageLiteral(resourceName: "share"), title: "SNS 공유하기")
        ]
    
    let forEditDelete: [DownloadShare] = [
        DownloadShare(image: #imageLiteral(resourceName: "edit"), title: "수정하기"),
        DownloadShare(image: #imageLiteral(resourceName: "delete"), title: "지우기"),
        ]
    
    let forComment: [DownloadShare] = [
        DownloadShare(image: #imageLiteral(resourceName: "edit"), title: "수정하기"),
        DownloadShare(image: #imageLiteral(resourceName: "delete"), title: "지우기"),
        ]
    
    var delegate: MainViewVCDelegate?
    var categoryArray = [String]()
    var hashTagTitle: String?
    var isDeleted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupSearchedTitle()
        setupWebView()
        setupContraints()
        swipeLeftAndRight()

        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = .black
        setupNavigationBar(navigationController: navigationController!, navigationItem: navigationItem, titile: "")
        setupSearchedTitle()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if let isFromSearchView = isFromSearchedView {
            if isFromSearchView {
                delegate?.willComeBackFromSearchedResultView(isFrom: true)
            } else {
                delegate?.willComeBackFromSearchedResultView(isFrom: false)
            }
        } else {
            if !isDeleted {
                guard let idx = selectedIdx else { return }
                delegate?.willGoBackHome(isFromNewPage: true, idx: idx)
            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        handleCommentEdit()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.webView.frame.origin.y = 0
        }, completion: nil)
        return true
    } 
}








































