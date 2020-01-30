//
//  SettingsViewController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 30/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

class SettingsItem: NSObject {
    let title: String
    
    init(withTitle title: String) {
        self.title = title
    }
}

class SettingsViewController: UIViewController,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var agreement: String?
    var privacy: String?
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
    
    let titleNamesArray: [SettingsItem] = {
        return [ SettingsItem(withTitle: "알림설정"),
                 SettingsItem(withTitle: "공지사항"),
                 SettingsItem(withTitle: "등대지기 우편함"),
                 SettingsItem(withTitle: "프로그램 정보"),
                 SettingsItem(withTitle: "멘토/도움주신분들")]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIService.instance.fetchAgreement { (agreement) in
            self.agreement = agreement
        }
        
        APIService.instance.fetchPrivacy { (privacy) in
            print(privacy)
            self.privacy = privacy
        }

        view.backgroundColor = .white
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        setupNavigationBar(navigationController: navigationController!, navigationItem: navigationItem, titile: "")
        navigationItem.title = "설정"
        setupComponents()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        setupNavigationBar(navigationController: navigationController!, navigationItem: navigationItem, titile: "")
    }
    
    func setupComponents() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        collectionView.register(SettingsItemViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsItemViewCell
        
        let eachItem = titleNamesArray[indexPath.row]
        cell.settingItem = eachItem
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if indexPath.row == 0
        {
            let notificationSettingsController = NotificationSettingsController()
            navigationController?.pushViewController(notificationSettingsController, animated: true)
        }
        else if indexPath.row == 1
        {
            let announcementViewController = AnnouncementViewController()
            navigationController?.pushViewController(announcementViewController, animated: true)
        }
        else if indexPath.row == 2
        {
            let postBoxViewController = PostBoxViewController()
            navigationController?.pushViewController(postBoxViewController, animated: true)
        }
        else if indexPath.row == 3
        {
            let programInfoViewController = ProgramInfoViewController()
            programInfoViewController.privacy = self.privacy
            programInfoViewController.agreement = self.agreement
            navigationController?.pushViewController(programInfoViewController, animated: true)
        }
        else if indexPath.row == 4
        {
            let metorsHelpersViewController = MetorsHelpersViewController()
            navigationController?.pushViewController(metorsHelpersViewController, animated: true)
        }
    }
}
