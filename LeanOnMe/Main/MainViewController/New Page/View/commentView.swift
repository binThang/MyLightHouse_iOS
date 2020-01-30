//
//  commentView.swift
//  LeanOnMe
//
//  Created by Justin Ji on 08/11/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {
    
    let topContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bottomContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let horizontalBorder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "c2c2c2")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let verticalBorder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "c2c2c2")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var commentTextView: UITextField = {
        let textfield = UITextField()
        textfield.textColor = UIColor.init(hexString: "474747")
        textfield.font = notoSansUIRegular(14)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(UIColor.init(hexString: "a7a7a7"), for: .normal)
        button.titleLabel?.font = notoSansUIRegular(14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("등록", for: .normal)
        button.setTitleColor(UIColor.init(hexString: "0c0958"), for: .normal)
        button.titleLabel?.font = notoSansUIRegular(14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupComponents()
    }
    
    func setupComponents() {
        
        view.addSubview(topContainerView)
        view.addSubview(bottomContainerView)
        view.addSubview(horizontalBorder)
        view.addSubview(verticalBorder)
        view.addSubview(commentTextView)
        view.addSubview(cancelButton)
        view.addSubview(completeButton)
        
        NSLayoutConstraint.activate([
            
            topContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            topContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -41),
            
            horizontalBorder.topAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            horizontalBorder.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            horizontalBorder.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            horizontalBorder.heightAnchor.constraint(equalToConstant: 1),
            
            bottomContainerView.topAnchor.constraint(equalTo: horizontalBorder.bottomAnchor),
            bottomContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            verticalBorder.topAnchor.constraint(equalTo: bottomContainerView.topAnchor),
            verticalBorder.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor),
            verticalBorder.widthAnchor.constraint(equalToConstant: 1),
            verticalBorder.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor),
            
            
            commentTextView.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor),
            commentTextView.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor),
            commentTextView.widthAnchor.constraint(equalToConstant: 150),
            
            
            completeButton.topAnchor.constraint(equalTo: bottomContainerView.topAnchor),
            completeButton.leadingAnchor.constraint(equalTo: verticalBorder.trailingAnchor),
            completeButton.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor),
            completeButton.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor),
            
            cancelButton.topAnchor.constraint(equalTo: bottomContainerView.topAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: verticalBorder.leadingAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor),
            
            ])
        
    }
    
   
    
}

























































