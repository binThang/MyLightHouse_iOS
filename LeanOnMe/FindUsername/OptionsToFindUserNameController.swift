//
//  OptionsToFindUserNameController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 25/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

class OptionsToFindUserNameController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디를 잊으셨나요?"
        label.textColor = UIColor.init(hexString: "#131215")
        label.font = notoSansUIBold(21)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "가입시 입력한 번호를 정확히 입력해 주세요 :)"
        label.textColor = UIColor.init(hexString: "#626262")
        label.font = notoSansUIRegular(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var withPhoneNumber: UIButton = {
        let button = UIButton()
        button.setTitle("전화번호로 찾기", for: .normal)
        button.setTitleColor(UIColor.init(hexString: "333333"), for: .normal)
        button.titleLabel?.font = notoSansUIRegular(14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(HandleWithPhonenumber), for: .touchUpInside)
        return button
    }()
    
    lazy var withEmail: UIButton = {
        let button = UIButton()
        button.setTitle("이메일로 찾기", for: .normal)
        button.setTitleColor(UIColor.init(hexString: "333333"), for: .normal)
        button.titleLabel?.font = notoSansUIRegular(14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(HandleWithEmail), for: .touchUpInside)

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupNavigationBar(navigationController: navigationController!, navigationItem: navigationItem, titile: "아이디 찾기")
        setupComponents()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar(navigationController: navigationController!, navigationItem: navigationItem, titile: "아이디 찾기")
    }
    
    func setupComponents() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(withPhoneNumber)
        view.addSubview(withEmail)
        
        NSLayoutConstraint.activate([
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 111),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.heightAnchor.constraint(equalToConstant: 12),
            
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 9),
            subtitleLabel.widthAnchor.constraint(equalToConstant: 250),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 15),
            
            
            withPhoneNumber.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            withPhoneNumber.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 62),
            withPhoneNumber.widthAnchor.constraint(equalToConstant: view.frame.width - 90),
            withPhoneNumber.heightAnchor.constraint(equalToConstant: 40),
            
            withEmail.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            withEmail.topAnchor.constraint(equalTo: withPhoneNumber.bottomAnchor, constant: 11),
            withEmail.widthAnchor.constraint(equalToConstant: view.frame.width - 90),
            withEmail.heightAnchor.constraint(equalToConstant: 40),
            ])
    }
    @objc func HandleWithPhonenumber() {
        let withPhoneNumberViewController = WithPhoneNumberViewController()
    navigationController?.pushViewController(withPhoneNumberViewController, animated: true)
    }
    
    @objc func HandleWithEmail() {
        let withEmailViewController = WithEmailViewController()
        navigationController?.pushViewController(withEmailViewController, animated: true)
    }
    
}










































































