//
//  SideMenuView.swift
//  LeanOnMe
//
//  Created by Justin Ji on 30/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

class MenuItem: NSObject {
    let title: String
    
    init(withTitle title: String) {
        self.title = title
    }
}

class SideMenuLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let dimmedView = UIView()
    var mainViewController = MainViewController()
    
    lazy var sideMenuView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "hamburger_logo"))
        return imageView
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "nickname"
        label.textAlignment = .right
        label.font = komaconFont(20)
        return label
    }()
    
    var nicknameLabelWidth: Int = 55
    
    let afterNicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "님 반가워요."
        label.font = komaconFont(13)
        return label
    }()
    
    let border: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "bdbdbd")
        return view
    }()
    
    let titleNamesArray: [MenuItem] = {
        return [ MenuItem(withTitle: "내 등에 기대"),
                 MenuItem(withTitle: "나도 그래"),
                 MenuItem(withTitle: "뻔해도 좋은"),
                 MenuItem(withTitle: "나의 다이어리"),
                 MenuItem(withTitle: "설정"),]
    }()
    
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
    
    let horizontalBorder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "bdbdbd")
        return view
    }()
    
    let verticalBorder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "bdbdbd")
        return view
    }()
    
    lazy var signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(UIColor.init(hexString: "063251"), for: .normal)
        button.titleLabel?.font = komaconFont(14)
        return button
    }()
    
    lazy var deregistrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원탈퇴", for: .normal)
        button.setTitleColor(UIColor.init(hexString: "063251"), for: .normal)
        button.titleLabel?.font = komaconFont(14)
        button.layer.borderColor = UIColor.init(hexString: "bdbdbd").cgColor
        return button
    }()
    
    
    
    func showSideMenu(WithNickname nickname: String, withWidth width: Int) {
        if let window = UIApplication.shared.keyWindow {
            
            //dimmedView
            dimmedView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            window.addSubview(dimmedView)
            
            dimmedView.frame = CGRect(x: 0, y: 20, width: window.frame.width, height: window.frame.height - 20)
            dimmedView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            //sideMenuView
            window.addSubview(sideMenuView)
            sideMenuView.frame = CGRect(x: 0, y: 20, width: 0, height: window.frame.height - 20)
            
            //logoImageView
            sideMenuView.addSubview(logoImageView)
            logoImageView.frame = CGRect(x: 0, y: 51, width: 0, height: 0)
            
            sideMenuView.addSubview(nicknameLabel)
            nicknameLabel.text = nickname
            nicknameLabel.frame = CGRect(x: 0, y: 51 + logoImageView.frame.height + 23, width: 0, height: 0)
            
            sideMenuView.addSubview(afterNicknameLabel)
            afterNicknameLabel.frame = CGRect(x: 0, y: nicknameLabel.frame.origin.y, width: 0, height: 20)
            
            
            sideMenuView.addSubview(border)
            border.frame = CGRect(x: 0, y: (self.nicknameLabel.frame.origin.y + self.nicknameLabel.frame.height + 31), width: 0, height: 0)
            
            sideMenuView.addSubview(collectionView)
            let borderYAnchor = (self.nicknameLabel.frame.origin.y + self.nicknameLabel.frame.height + 31 + border.frame.height)
            collectionView.frame = CGRect(x: 0, y: borderYAnchor, width: 0, height: 0)
            collectionView.register(MenuItemTitleCell.self, forCellWithReuseIdentifier: cellId)
            
            sideMenuView.addSubview(signOutButton)
            signOutButton.frame = CGRect(x: 0, y: (sideMenuView.frame.height - 48), width: 0, height: 0)
            
            sideMenuView.addSubview(deregistrationButton)
            deregistrationButton.frame = CGRect(x: 0, y: (sideMenuView.frame.height - 48), width: 0, height: 0)
            
            sideMenuView.addSubview(verticalBorder)
            sideMenuView.addSubview(horizontalBorder)
            horizontalBorder.frame = CGRect(x: 0, y: signOutButton.frame.origin.y, width: 0, height: 0)
            verticalBorder.frame = CGRect(x: 0, y: signOutButton.frame.origin.y, width: 0, height: 0)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.dimmedView.alpha = 1
                self.sideMenuView.frame = CGRect(x: 0, y: 0, width: 300, height: window.frame.height)
                self.logoImageView.frame = CGRect(x: self.sideMenuView.frame.width/2 - 79/2, y: 51, width: 79, height: 64)
                self.nicknameLabel.frame = CGRect(x: 0, y: Int(51 + self.logoImageView.frame.height + 23), width: 160, height: 20)
                self.afterNicknameLabel.frame = CGRect(x: Int(2 + self.nicknameLabel.frame.width), y: Int(self.nicknameLabel.frame.origin.y + 2), width: 100, height: 20)
                self.border.frame = CGRect(x: 30, y: (self.nicknameLabel.frame.origin.y + self.nicknameLabel.frame.height + 31), width: self.sideMenuView.frame.width - 60, height: 1)
                
                let borderYAnchor = (self.nicknameLabel.frame.origin.y + self.nicknameLabel.frame.height + 31 + self.border.frame.height)
                self.collectionView.frame = CGRect(x: 0, y: borderYAnchor + 34, width: self.sideMenuView.frame.width, height: 300)
                
                
                self.signOutButton.frame = CGRect(x: -1, y: (self.sideMenuView.frame.height - 48), width: self.sideMenuView.frame.width/2, height: 48)
                
                self.deregistrationButton.frame = CGRect(x: self.signOutButton.frame.width - 1, y: (self.sideMenuView.frame.height - 48), width: self.sideMenuView.frame.width/2 + 1, height: 48)
                
                self.horizontalBorder.frame = CGRect(x: 0, y: self.signOutButton.frame.origin.y, width: self.signOutButton.frame.width*2, height: 1)
                self.verticalBorder.frame = CGRect(x: self.signOutButton.frame.width, y: self.signOutButton.frame.origin.y, width: 1, height: self.signOutButton.frame.height)
            }, completion: nil)
            
            
        }
    }
    
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            if let window = UIApplication.shared.keyWindow {
                
                self.dimmedView.alpha = 0
                
                self.sideMenuView.frame = CGRect(x: 0, y: 20, width: 0, height: window.frame.height - 20)
                self.logoImageView.frame = CGRect(x: 0, y: 51, width: 0, height: 0)
                
                self.nicknameLabel.frame = CGRect(x: 0, y: 51 + self.logoImageView.frame.height + 23, width: 0, height: 0)
                self.afterNicknameLabel.frame = CGRect(x: 0, y: self.nicknameLabel.frame.origin.y, width: 0, height: 0)
                
                
                self.border.frame = CGRect(x: 0, y: (self.nicknameLabel.frame.origin.y + self.nicknameLabel.frame.height + 31), width: 0, height: 0)
                
                let borderYAnchor = (self.nicknameLabel.frame.origin.y + self.nicknameLabel.frame.height + 31 + self.border.frame.height)
                
                self.collectionView.frame = CGRect(x: 0, y: borderYAnchor, width: 0, height: 0)
                
                self.signOutButton.frame = CGRect(x: 0, y: (self.sideMenuView.frame.height - 48), width: 0, height: 0)
                
                self.deregistrationButton.frame = CGRect(x: 0, y: (self.sideMenuView.frame.height - 48), width: 0, height: 0)
                
                self.horizontalBorder.frame = CGRect(x: 0, y: self.signOutButton.frame.origin.y, width: 0, height: 0)
                self.verticalBorder.frame = CGRect(x: 0, y: self.signOutButton.frame.origin.y, width: 0, height: 0)
                
            }
        }, completion: nil)
    }
    
    
    func handleDismissAndPush(menuItem: MenuItem) {
        
        handleDismiss()
        if menuItem.title != "" {
            self.mainViewController.showControllerForItem(withMenuItem: menuItem)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuItemTitleCell
        let eachItem = titleNamesArray[indexPath.row]
        cell.menuItem = eachItem
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: sideMenuView.frame.width, height: 30)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 29
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let menuItem = self.titleNamesArray[indexPath.row]
        handleDismissAndPush(menuItem: menuItem)
    }
}











































































