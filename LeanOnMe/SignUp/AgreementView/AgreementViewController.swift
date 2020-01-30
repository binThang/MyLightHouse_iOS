//
//  AgreementViewController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 27/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

class AgreementViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    var isAgreed: Bool?
    
    let customStatusBar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let customNavgationBar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        view.layer.shadowRadius = 2
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "서약내용"
        label.textAlignment = .center
        label.font = yacheFont(18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(handleAllAgreed(_:)), name: Notification.Name("allAgreed"), object: nil)
        
        
        navigationItem.title = "서약내용"
        setupComponents()
        
    }
    
    @objc func handleAllAgreed(_ notification: Notification) {
        
        let message = notification.userInfo!["result"] as! String
        if message == "good" {
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "미동의 오류", message: "서약내용에 모두 동의해 주세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func setupComponents() {
        view.addSubview(customStatusBar)
        view.addSubview(customNavgationBar)
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            
            customStatusBar.topAnchor.constraint(equalTo: view.topAnchor),
            customStatusBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customStatusBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customStatusBar.heightAnchor.constraint(equalToConstant: 20),
            
            customNavgationBar.topAnchor.constraint(equalTo: customStatusBar.bottomAnchor),
            customNavgationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavgationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavgationBar.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.centerYAnchor.constraint(equalTo: customNavgationBar.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: customNavgationBar.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            
            collectionView.topAnchor.constraint(equalTo: customNavgationBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])

        collectionView.register(AgreementViewCell.self, forCellWithReuseIdentifier: cellId)
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AgreementViewCell
        
        
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height + 150)
    }
}














































































































