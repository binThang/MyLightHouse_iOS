//
//  VerificationController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 25/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

public var isSwitchedToEmail: Bool = false //false일때는 문자인증, true일때는 이메일 인증
public var phoneNumberVerified: String?
public var emailAddressVerified: String?

class VerificationController: UIViewController {
    
    var randomNumber: String?
    var isVerificationSent: Bool = false //중복확인이 되고 인증번호가 보내지면 true로 변경된다.
    var isVerified: Bool = false //인증이 끝나면 true로 값이 변경되고, 회원가입 페이지로 이동이 가능하다.
    var isVerificationNumberSent: Bool = false //인증번호가 성공적으로 보내졌는지 아닌지를 나타낸다.
    var isPhoneSelected: Bool = false //인증 방법이 폰일때는 true, 이메일 일때는 false
    
    lazy var phoneNumberOrEmailTextfield: UITextField = {
        let textfield = UITextField()
        textfield.font = komaconFont(13)
        textfield.attributedPlaceholder = NSAttributedString(string: "휴대폰 번호를 입력해 주세요.", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.8), NSAttributedStringKey.font: komaconFont(13)])
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        textfield.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        textfield.layer.borderWidth = 1
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.addTarget(self, action: #selector(handlePhoneNumberOrEamilTextfield), for: .editingChanged)
        return textfield
    }()

    lazy var sendVerficationNumberButton: UIButton = {
        let button = UIButton()
        button.setTitle("인증요청", for: .normal)
        button.setTitleColor(UIColor.lightGray.withAlphaComponent(0.8), for: .normal)
        button.titleLabel?.font = komaconFont(13)
        button.backgroundColor = UIColor.white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        button.addTarget(self, action: #selector(handleSendVerficationNumber), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let verficationNumberTextfield: UITextField = {
        let textfield = UITextField()
        textfield.font = komaconFont(13)
        textfield.attributedPlaceholder = NSAttributedString(string: "인증번호 입력란", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.8), NSAttributedStringKey.font: komaconFont(13)])
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        textfield.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        textfield.layer.borderWidth = 1
        textfield.keyboardType = .numberPad
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.addTarget(self, action: #selector(handleverficationNumberTextfield), for: .editingChanged)
        return textfield
    }()

    lazy var verfiyPhoneNumberButton: UIButton = {
        let button = UIButton()
        button.setTitle("인증확인", for: .normal)
       button.setTitleColor(UIColor.lightGray.withAlphaComponent(0.8), for: .normal)
        button.titleLabel?.font = komaconFont(13)
        button.backgroundColor = UIColor.white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleVerify), for: .touchUpInside)
        return button
    }()
    
    lazy var switchToEmailVerification: UILabel = {
        let label = UILabel()
        label.text = "이메일로 인증하기"
        label.font = komaconFont(12)
        label.textColor = UIColor.init(hexString: "FBAE35")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSwitch)))
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        let gradientx = CAGradientLayer()
        gradientx.colors = [UIColor.init(hexString: "fbac35").cgColor, UIColor.init(hexString: "fbd135").cgColor]
        gradientx.startPoint = CGPoint(x: 0, y: 1)
        gradientx.endPoint = CGPoint(x: 0.8, y: 1)
        gradientx.frame = view.bounds
        button.layer.addSublayer(gradientx)
        button.layer.masksToBounds = false
        button.setTitle("다음", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = notoSansUIBold(20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleNextButton), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupNavigationBar(navigationController: navigationController!, navigationItem: navigationItem, titile: "본인인증")
         view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissKeyboard)))
        setupComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
}

































































