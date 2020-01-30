//
//  WithEmailViewController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 25/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit
class WithEmailViewController: UIViewController {
    
    var username: String?
    var randomNumber: String?
    
   
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
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
    
    let dateOfBirthLabel: UILabel = {
        let label = UILabel()
        label.text = "생년월일"
        label.textColor = UIColor.init(hexString: "#131215")
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.font = notoSansUIBold(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateOfBirthTextfield: UITextField = {
        let textfield = UITextField()
        textfield.font = notoSansUIRegular(14)
        textfield.keyboardType = .numberPad
        textfield.attributedPlaceholder = NSAttributedString(string: "생년월일을 입력해주세요.", attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(hexString: "#131215").withAlphaComponent(0.3), NSAttributedStringKey.font: komaconFont(14)])
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
    
    let emailTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일 주소"
        label.textColor = UIColor.init(hexString: "#131215")
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.font = notoSansUIBold(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailTextfield: UITextField = {
        let textfield = UITextField()
        textfield.font = notoSansUIRegular(14)
        textfield.keyboardType = .emailAddress
        textfield.attributedPlaceholder = NSAttributedString(string: "이메일 주소를 입력해 주세요.", attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(hexString: "#131215").withAlphaComponent(0.3), NSAttributedStringKey.font: notoSansUIRegular(14)])
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let emailBottomLine: UIView = {
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
    
    let labelOne: UILabel = {
        let label = UILabel()
        label.text = "회원님의 아이디는"
        label.textAlignment = .center
        label.textColor = UIColor.init(hexString: "8d8d8d")
        label.font = notoSansUIRegular(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let resultView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let usernameLabelReceived: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(hexString: "131215")
        label.font = notoSansUIRegular(13)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelTwo: UILabel = {
        let label = UILabel()
        label.text = "입니다."
        label.textColor = UIColor.init(hexString: "8d8d8d")
        label.font = notoSansUIRegular(13)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    var measuredWidth: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupNavigationBar(navigationController: navigationController!, navigationItem: navigationItem, titile: "아이디 찾기")
        setupComponents()
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissKeyboard)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        removeGradientColour()
        dateOfBirthTextfield.text = ""
        emailTextfield.text = ""
        navigationController?.navigationBar.isHidden = false
        
        if let username = username {
            measuredWidth = CGFloat(estimateFrameForText(text: "\(username) \(labelTwo.text!)").width + CGFloat(20))
            resultView.widthAnchor.constraint(equalToConstant: measuredWidth).isActive = true
            view.layoutIfNeeded()
            if isUsernameVerified {
                
                self.usernameBackgroundView.alpha = 1
                self.labelOne.isHidden = false
                self.labelTwo.isHidden = false
                self.usernameLabelReceived.isHidden = false
                self.resultView.alpha = 1              
                self.usernameLabelReceived.text = username
                
            }
        }
    }

}
