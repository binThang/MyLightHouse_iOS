//
//  PostBoxViewController.swift
//  LeanOnMe
//
//  Created by Bae Yong Bin on 2018. 2. 4..
//  Copyright © 2018년 Justin Ji. All rights reserved.
//

import UIKit

class PostBoxItem: NSObject
{
    let title: String
    
    init(withTitle title: String)
    {
        self.title = title
    }
}

class PostBoxViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    let cellId = "cellId"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        setupNavigationBar(navigationController: navigationController!, navigationItem: navigationItem, titile: "")
        navigationItem.title = "등대지기 우편함"
        setupComponents()
    }
    
    let titleNamesArray: [PostBoxItem] = {
        return [ PostBoxItem(withTitle: "등대에 물어보기(문의&제안)"),
                 PostBoxItem(withTitle: "책 신청하기")]
    }()
    
    func setupComponents() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        
        collectionView.register(PostBoxViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PostBoxViewCell
        
        let eachItem = titleNamesArray[indexPath.row]
        cell.settingItem = eachItem
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        setupNavigationBar(navigationController: navigationController!, navigationItem: navigationItem, titile: "")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if indexPath.row == 0
        {
            let notificationSettingsController = EnqueryViewController()
            navigationController?.pushViewController(notificationSettingsController, animated: true)
        }
        else if indexPath.row == 1
        {
            let announcementViewController = BookRequestViewController()
            navigationController?.pushViewController(announcementViewController, animated: true)
        }
    }
    
    @objc func handleDismiss() {
        view.endEditing(true)
    }
}
