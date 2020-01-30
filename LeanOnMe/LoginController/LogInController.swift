//
//  ViewController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 18/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

class LogInController: UIViewController {

    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "login_back")
        imageView.contentMode = .scaleAspectFit
        
        if(UIDevice.current.userInterfaceIdiom == .pad)
        {
            imageView.contentMode = .scaleToFill;
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "login_logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        label.font = komaconFont(13)
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let usernameTextfield: UITextField = {
        let textfield = UITextField()
        textfield.font = komaconFont(14)
        textfield.attributedPlaceholder = NSAttributedString(string: "아이디를 입력해주세요.", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.6), NSAttributedStringKey.font: komaconFont(14)])
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 30))
        textfield.leftView = paddingView
        textfield.textColor = .white
        textfield.font = komaconFont(14)
        textfield.leftViewMode = .always
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let usernameBottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = komaconFont(13)
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordTextfield: UITextField = {
        let textfield = UITextField()
        textfield.font = komaconFont(14)
        textfield.textColor = .white
        textfield.isSecureTextEntry = true
        textfield.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력해주세요.", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.6), NSAttributedStringKey.font: komaconFont(14)])
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 30))
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let passwordBottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = komaconFont(16)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLogIn), for: .touchUpInside)
        return button
    }()
    
    let bottomWhitePart: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(UIColor.init(hexString: "#161616"), for: .normal)
        button.titleLabel?.font = komaconFont(13)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    let sideBarOne: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "#161616")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var findUsernameUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("아이디 찾기", for: .normal)
        button.setTitleColor(UIColor.init(hexString: "#161616"), for: .normal)
        button.titleLabel?.font = komaconFont(13)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleFindUsername), for: .touchUpInside)
        return button
    }()
    
    let sideBarTwo: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "#161616")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var findPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 찾기", for: .normal)
        button.setTitleColor(UIColor.init(hexString: "#161616"), for: .normal)
        button.titleLabel?.font = komaconFont(13)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleFindPassword), for: .touchUpInside)
        return button
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        UIApplication.shared.statusBarStyle = .lightContent
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissKeyboard)))
        setupComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    func setupComponents() {
        view.addSubview(backgroundImageView)
        view.addSubview(logoImageView)
        view.addSubview(usernameLabel)
        view.addSubview(usernameTextfield)
        view.addSubview(usernameBottomLine)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextfield)
        view.addSubview(passwordBottomLine)
        view.addSubview(logInButton)
        view.addSubview(bottomWhitePart)
        view.addSubview(signUpButton)
        view.addSubview(sideBarOne)
        view.addSubview(findUsernameUpButton)
        view.addSubview(sideBarTwo)
        view.addSubview(findPasswordButton)
        
        //MARK: LogIn Constraints
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 73),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 109),
            logoImageView.heightAnchor.constraint(equalToConstant: 87),
            
            usernameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 56),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 54),
            usernameLabel.widthAnchor.constraint(equalToConstant: 50),
            usernameLabel.heightAnchor.constraint(equalToConstant: 12),
            
            usernameTextfield.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 13),
            usernameTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 61),
            usernameTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -54),
            usernameTextfield.heightAnchor.constraint(equalToConstant: 13),
            
            usernameBottomLine.topAnchor.constraint(equalTo: usernameTextfield.bottomAnchor, constant: 9),
            usernameBottomLine.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            usernameBottomLine.trailingAnchor.constraint(equalTo: usernameTextfield.trailingAnchor),
            usernameBottomLine.heightAnchor.constraint(equalToConstant: 1),
            
            
            passwordLabel.topAnchor.constraint(equalTo: usernameBottomLine.bottomAnchor, constant: 39),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 54),
            passwordLabel.widthAnchor.constraint(equalToConstant: 60),
            passwordLabel.heightAnchor.constraint(equalToConstant: 13),
            
            passwordTextfield.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 13),
            passwordTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 61),
            passwordTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -54),
            passwordTextfield.heightAnchor.constraint(equalToConstant: 15),
            
            passwordBottomLine.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 9),
            passwordBottomLine.leadingAnchor.constraint(equalTo: passwordLabel.leadingAnchor),
            passwordBottomLine.trailingAnchor.constraint(equalTo: passwordTextfield.trailingAnchor),
            passwordBottomLine.heightAnchor.constraint(equalToConstant: 1),
        
            logInButton.topAnchor.constraint(equalTo: passwordBottomLine.bottomAnchor, constant: 21),
            logInButton.trailingAnchor.constraint(equalTo: passwordBottomLine.trailingAnchor),
            logInButton.widthAnchor.constraint(equalToConstant: 79),
            logInButton.heightAnchor.constraint(equalToConstant: 31),
            
            bottomWhitePart.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomWhitePart.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomWhitePart.widthAnchor.constraint(equalToConstant: view.frame.width),
            bottomWhitePart.heightAnchor.constraint(equalToConstant: 47),
            
            signUpButton.centerYAnchor.constraint(equalTo: bottomWhitePart.centerYAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: sideBarOne.leadingAnchor, constant: -10),
            signUpButton.widthAnchor.constraint(equalToConstant: 50),
            signUpButton.heightAnchor.constraint(equalToConstant: 30),
            
            sideBarOne.centerYAnchor.constraint(equalTo: bottomWhitePart.centerYAnchor),
            sideBarOne.leadingAnchor.constraint(equalTo: findUsernameUpButton.leadingAnchor, constant: -10),
            sideBarOne.widthAnchor.constraint(equalToConstant: 1),
            sideBarOne.heightAnchor.constraint(equalToConstant: 7),
            
            findUsernameUpButton.centerYAnchor.constraint(equalTo: bottomWhitePart.centerYAnchor),
            findUsernameUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            findUsernameUpButton.widthAnchor.constraint(equalToConstant: 60),
            findUsernameUpButton.heightAnchor.constraint(equalToConstant: 30),
            
            sideBarTwo.centerYAnchor.constraint(equalTo: bottomWhitePart.centerYAnchor),
            sideBarTwo.leadingAnchor.constraint(equalTo: findUsernameUpButton.trailingAnchor, constant: 10),
            sideBarTwo.widthAnchor.constraint(equalToConstant: 1),
            sideBarTwo.heightAnchor.constraint(equalToConstant: 7),
            
            findPasswordButton.centerYAnchor.constraint(equalTo: bottomWhitePart.centerYAnchor),
            findPasswordButton.leadingAnchor.constraint(equalTo: sideBarTwo.trailingAnchor, constant: 10),
            findPasswordButton.widthAnchor.constraint(equalToConstant: 75),
            findPasswordButton.heightAnchor.constraint(equalToConstant: 30),
            ])
        
    
    }
  


}






































































































