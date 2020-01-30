//
//  SignUpViewCell.swift
//  LeanOnMe
//
//  Created by Justin Ji on 18/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

class SignUpViewCell: UICollectionViewCell, UINavigationControllerDelegate {
    
    var randomNumber: String?
    var isUsernameChecked: Bool = false
    var isNicknameChecked: Bool = false
    var isMaleChecked: Bool = false
    var isFemaleChecked: Bool = false
    var isPromiseChecked: Bool = false
    var isAgreeChecked: Bool = false
    var isPasswordChecked: Bool = false
    var isPhoneNumberVerified: Bool = false
    var isAgreementViewed: Bool = false
    var gender: Int?
    var phoneNumber: String?
    var email: String?
    let agreementController = AgreementViewCell()
    
    let welcomeTitle: UILabel = {
        let label = UILabel()
        label.text = "환영합니다 :)"
        label.textColor = UIColor.init(hexString: "#131215")
        label.font = komaconFont(21)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
        label.text = "자유로운 익명의 소통공간!"
        label.textColor = UIColor.init(hexString: "#626262")
        label.font = komaconFont(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        label.textColor = UIColor.init(hexString: "#3D3A42")
        label.font = komaconFont(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var usernameTextfield: UITextField = {
        let textfield = UITextField()
        textfield.font = komaconFont(13)
        textfield.attributedPlaceholder = NSAttributedString(string: "영문자 4 이상!10자 미만", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.8), NSAttributedStringKey.font: UIFont(name: "NotoSansUI", size: 13)!])
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textfield.leftView = paddingView
        textfield.keyboardType = .emailAddress
        textfield.leftViewMode = .always
        textfield.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        textfield.layer.borderWidth = 1
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.addTarget(self, action: #selector(handleUsernameTextfield), for: .editingChanged)
        return textfield
    }()
    
    lazy var verfiyUsernameButton: UIButton = {
        let button = UIButton()
        button.setTitle("중복확인", for: .normal)
        button.setTitleColor(UIColor.lightGray.withAlphaComponent(0.8), for: .normal)
        button.titleLabel?.font = komaconFont(13)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(handleCheckUsername), for: .touchUpInside)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.textColor = UIColor.init(hexString: "#3D3A42")
        label.font = komaconFont(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nicknameTextfield: UITextField = {
        let textfield = UITextField()
        textfield.font = komaconFont(13)
        textfield.attributedPlaceholder = NSAttributedString(string: "2자 이상", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.8), NSAttributedStringKey.font: komaconFont(13)])
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        textfield.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        textfield.layer.borderWidth = 1
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.addTarget(self, action: #selector(handleNicknameTextfield), for: .editingChanged)
        return textfield
    }()
    
    lazy var verfiyNicknameButton: UIButton = {
        let button = UIButton()
        button.setTitle("중복확인", for: .normal)
        button.setTitleColor(UIColor.lightGray.withAlphaComponent(0.8), for: .normal)
        button.titleLabel?.font = komaconFont(13)
        button.backgroundColor = UIColor.white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        button.addTarget(self, action: #selector(handleCheckNickname), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.textColor = UIColor.init(hexString: "#3D3A42")
        label.font = komaconFont(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var passwordTextfield: UITextField = {
        let textfield = UITextField()
        textfield.font = komaconFont(14)
        textfield.attributedPlaceholder = NSAttributedString(string: "4자 이상", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.8), NSAttributedStringKey.font: komaconFont(13)])
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        textfield.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        textfield.layer.borderWidth = 1
        textfield.isSecureTextEntry = true
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.addTarget(self, action: #selector(handlePasswordTextfield), for: .editingDidEnd)
        return textfield
    }()
    
    lazy var doubleCheckPasswordTextfield: UITextField = {
        let textfield = UITextField()
        textfield.font = komaconFont(14)
        textfield.attributedPlaceholder = NSAttributedString(string: "비밀번호 확인", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.8), NSAttributedStringKey.font: komaconFont(13)])
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        textfield.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        textfield.layer.borderWidth = 1
        textfield.isSecureTextEntry = true
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.addTarget(self, action: #selector(handleDoubleCheckPassword), for: .editingDidEnd)
        return textfield
    }()
    
    let passwordCheckLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(hexString: "#ffb445")
        label.font = komaconFont(12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "성별(선택사항)"
        label.textColor = UIColor.init(hexString: "#3D3A42")
        label.font = komaconFont(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let maleLabel: UILabel = {
        let label = UILabel()
        label.text = "남"
        label.textColor = UIColor.init(hexString: "#3D3A42")
        label.font = komaconFont(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let femaleLabel: UILabel = {
        let label = UILabel()
        label.text = "여"
        label.textColor = UIColor.init(hexString: "#3D3A42")
        label.font = komaconFont(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var checkBoxForMale: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor.init(hexString: "#b5b5b5").cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 8.5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(hanldeButtonForMale), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var checkBoxForFemale: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor.init(hexString: "#b5b5b5").cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 8.5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(hanldeButtonForFemale), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let dateOfBirthLabel: UILabel = {
        let label = UILabel()
        label.text = "생년월일(선택사항)"
        label.textColor = UIColor.init(hexString: "#3D3A42")
        label.font = komaconFont(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateOfBirthTextfield: UITextField = {
        let textfield = UITextField()
        textfield.font = komaconFont(13)
        textfield.attributedPlaceholder = NSAttributedString(string: "ID나 PW찾기 이외에는 활용하지 않습니다.", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.8), NSAttributedStringKey.font: komaconFont(13)])
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        textfield.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        textfield.layer.borderWidth = 1
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    lazy var openAgreementButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = UIColor.init(hexString: "#f7f7f7")
        let gradientLayer = CAGradientLayer()
        let topColour = UIColor.init(hexString: "fe2e2e2").cgColor
        let bottomColour = UIColor.init(hexString: "#f7f7f7").cgColor
        gradientLayer.colors = [topColour, bottomColour]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y:1.0)
        gradientLayer.frame = button.bounds
        button.layer.insertSublayer(gradientLayer, at: 0)
        button.layer.addSublayer(gradientLayer)
        button.layer.masksToBounds = false
        
        button.setTitle("서약내용 보기", for: .normal)
        button.setTitleColor(UIColor.init(hexString: "#3D3A42"), for: .normal)
        button.addTarget(self, action: #selector(handleOpenAgreement), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let promiseLabel: UILabel = {
        let label = UILabel()
        label.text = "약속합니다"
        label.textColor = UIColor.init(hexString: "#3D3A42")
        label.font = notoSansUIRegular(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var promiseButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePromise), for: .touchUpInside)
        return button
    }()
    
    let agreeLabel: UILabel = {
        let label = UILabel()
        label.text = "개인정보동의"
        label.textColor = UIColor.init(hexString: "#3D3A42")
        label.font = notoSansUIRegular(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var agreeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        button.addTarget(self, action: #selector(handleAgree), for: .touchUpInside)
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var completeButton: UIButton = {
        let button = UIButton()
        let gradientx = CAGradientLayer()
        gradientx.colors = [UIColor.init(hexString: "fbac35").cgColor, UIColor.init(hexString: "fbd135").cgColor]
        gradientx.startPoint = CGPoint(x: 0, y: 1)
        gradientx.endPoint = CGPoint(x: 0.8, y: 1)
        gradientx.frame = contentView.bounds
        button.layer.addSublayer(gradientx)
        button.layer.masksToBounds = false
        button.setTitle("가입완료", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = notoSansUIBold(15)
        button.backgroundColor = UIColor.init(hexString: "#ffb445")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCompleteSignUp), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBackToOriginal)))
        window?.backgroundColor = .white
        backgroundColor = .white
        addComponents()
   
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func willPassEmailOrPhoneNumber(withEmail email: String?, withPhoneNumber phoneNumber: String?) {
        self.email = email
        self.phoneNumber = phoneNumber
    }
   
}









































































