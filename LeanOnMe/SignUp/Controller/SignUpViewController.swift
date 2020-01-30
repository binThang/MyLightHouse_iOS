//
//  SignUpViewController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 18/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit



class SignUpViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    var isAgreementViewed: Bool = false
    
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
        

        setupNavigationBar(navigationController: navigationController!, navigationItem: navigationItem, titile: "내 등에 기대")
        view.backgroundColor = .white
        
        setupComponents()
        
        NotificationCenter.default.addObserver(self, selector: #selector(completeSignUp(_:)), name: Notification.Name("complete"), object: nil)
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    func setupComponents()
    {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        
        collectionView.register(SignUpViewCell.self, forCellWithReuseIdentifier: cellId)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SignUpViewCell

    cell.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissKeyboard)))
        
        cell.passwordTextfield.addTarget(self, action: #selector(handleDOBTextfield), for: .editingDidBegin)
        cell.doubleCheckPasswordTextfield.addTarget(self, action: #selector(handleDOBTextfield), for: .editingDidBegin)
        cell.dateOfBirthTextfield.addTarget(self, action: #selector(handleDOBTextfield), for: .editingDidBegin)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 800)
    }
}









































































