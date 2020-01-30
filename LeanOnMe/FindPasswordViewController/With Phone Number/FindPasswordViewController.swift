//
//  FindPasswordViewController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 19/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

class FindPasswordWithPhoneNumberViewController: UIViewController {
    
    var randomNumber: String?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호를 잊으셨나요?"
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
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        label.textColor = UIColor.init(hexString: "#131215")
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.font = notoSansUIRegular(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let usernameTextfield: UITextField = {
        let textfield = UITextField()
        textfield.font = notoSansUIRegular(14)
        textfield.attributedPlaceholder = NSAttributedString(string: "아이디를 입력해 주세요.", attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(hexString: "#131215").withAlphaComponent(0.3), NSAttributedStringKey.font: notoSansUIRegular(14)])
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let usernameBottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "#131215")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dateOfBirthLabel: UILabel = {
        let label = UILabel()
        label.text = "생년월일"
        label.textColor = UIColor.init(hexString: "#131215")
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.font = notoSansUIRegular(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateOfBirthTextfield: UITextField = {
        let textfield = UITextField()
        textfield.font = notoSansUIRegular(14)
        textfield.keyboardType = .numberPad
        textfield.attributedPlaceholder = NSAttributedString(string: "생년월일을 입력해주세요.", attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(hexString: "#131215").withAlphaComponent(0.3), NSAttributedStringKey.font: notoSansUIRegular(14)])
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let dateOfBirthBottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "#131215")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "휴대폰 번호"
        label.textColor = UIColor.init(hexString: "#131215")
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.font = notoSansUIRegular(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var phoneNumberTextfield: UITextField = {
        let textfield = UITextField()
        textfield.font = notoSansUIRegular(14)
        textfield.keyboardType = .numberPad
        textfield.attributedPlaceholder = NSAttributedString(string: "휴대전화 번호를 입력해 주세요.", attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(hexString: "#131215").withAlphaComponent(0.3), NSAttributedStringKey.font: notoSansUIRegular(14)])
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.addTarget(self, action: #selector(handleTextfield), for: .editingDidBegin)
        return textfield
    }()
    
    let phoneNumberBottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "#131215")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var verificationButton: UIButton = {
        let button = UIButton()
        button.setTitle("인증번호", for: .normal)
        button.setTitleColor(UIColor.init(hexString: "#b9b9b9"), for: .normal)
        button.titleLabel?.font = notoSansUIRegular(14)
        button.layer.borderColor = UIColor.init(hexString: "#bdbdbd").cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleVerification), for: .touchUpInside)
        return button
    }()

    lazy var gradientView: CAGradientLayer = {
        let gradientx = CAGradientLayer()
        gradientx.colors = [UIColor.init(hexString: "fbac35").cgColor, UIColor.init(hexString: "fbd135").cgColor]
        gradientx.startPoint = CGPoint(x: 0, y: 1)
        gradientx.endPoint = CGPoint(x: 0.8, y: 1)
        gradientx.frame = verificationButton.bounds
        gradientx.cornerRadius = verificationButton.layer.cornerRadius
        return gradientx
    }()
    
    lazy var verificationSuccess: UILabel = {
        let label = UILabel(frame: gradientView.bounds)
        label.text = "인증성공"
        label.textAlignment = .center
        label.textColor = .white
        label.font = notoSansUIRegular(14)
        return label
    }()
    
    let usernameBackgroundView: UIView = {
        let view = UIView()
        view.layer.borderColor = orangeColour.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .clear
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
       
        setupNavigationBar(navigationController: navigationController!, navigationItem: navigationItem, titile: "비밀번호 찾기")
        setupComponents()
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissKeyboard)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar(navigationController: navigationController!, navigationItem: navigationItem, titile: "비밀번호 찾기")
    }

   

}















































































