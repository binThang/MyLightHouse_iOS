//
//  BookRequestView.swift
//  LeanOnMe
//
//  Created by Bae Yong Bin on 2018. 2. 4..
//  Copyright © 2018년 Justin Ji. All rights reserved.
//

import UIKit

class BookRequestViewCell : UICollectionViewCell
{
    let emailTitle: UILabel = {
        let label = UILabel()
        label.text = "토니의 닉네임"
        label.font = komaconFont(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailTextfield: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "티니에게 책을 선물할 토니의 닉네임을 적어주세요."
        textfield.font = komaconFont(12)
        textfield.backgroundColor = .white
        textfield.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        textfield.layer.borderWidth = 1
        textfield.layer.cornerRadius = 5
        textfield.layer.masksToBounds = true
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textfield.leftView = leftPadding
        textfield.leftViewMode = .always
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let contentLabel: UILabel =
    {
        let label = UILabel()
        label.text = "주소"
        label.font = komaconFont(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var contentTextView: UITextField = {
        let textView = UITextField()
        textView.font = komaconFont(12)
        textView.placeholder = "티니가 책을 받으실 주소를 입력해주세요."
        textView.leftView = UIView(frame: CGRect(x:0, y:0, width:20, height:20))
        textView.leftViewMode = .always
        textView.textColor = UIColor.init(hexString: "C7C7CD")
        textView.backgroundColor = .white
        textView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5
        textView.layer.masksToBounds = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = komaconFont(15)
        button.backgroundColor = UIColor.init(hexString: "#ffb445")
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleComplete), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        setupComponents()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents()
    {
        addSubview(emailTitle)
        addSubview(emailTextfield)
        addSubview(contentLabel)
        addSubview(contentTextView)
        addSubview(completeButton)
        
        NSLayoutConstraint.activate([
            emailTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 39),
            emailTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 19),
            emailTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -19),
            emailTitle.heightAnchor.constraint(equalToConstant: 20),
            
            emailTextfield.topAnchor.constraint(equalTo: emailTitle.bottomAnchor, constant: 6),
            emailTextfield.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emailTextfield.widthAnchor.constraint(equalTo: emailTitle.widthAnchor),
            emailTextfield.heightAnchor.constraint(equalToConstant: 42),
            
            contentLabel.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: 20),
            contentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 19),
            contentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -19),
            contentLabel.heightAnchor.constraint(equalToConstant: 20),
            
            contentTextView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 6),
            contentTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentTextView.widthAnchor.constraint(equalTo: contentLabel.widthAnchor),
            contentTextView.heightAnchor.constraint(equalToConstant: 42),
            
            completeButton.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 20),
            completeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -19),
            completeButton.widthAnchor.constraint(equalToConstant: 79),
            completeButton.heightAnchor.constraint(equalToConstant: 30),
            ])
    }
    
    @objc func handleComplete()
    {
        guard let email = emailTextfield.text, let enquery = contentTextView.text else { return }
        
        if email == ""
        {
            let alert = UIAlertController(title: "입력 오류", message: "토니의 닉네임을 적어주세요.", preferredStyle: .alert)
            let action = UIAlertAction(title:"확인", style:.default, handler:{ (_) in
                self.emailTextfield.becomeFirstResponder()
            })
            
            alert.addAction(action)
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
        else if enquery == ""
        {
            let alert = UIAlertController(title: "입력 오류", message: "주소를 적어주세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: { (_) in
                self.contentTextView.becomeFirstResponder()
            })
            
            alert.addAction(action)
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
        else
        {
            APIService.instance.sendEnquery(withEmail: email, withEnquery: enquery)
            { (result) in
                if result == "success"
                {
                    let alert = UIAlertController(title: "문의 완료", message: "문의가 보내졌습니다. 감사합니다.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .default, handler: { (_) in
                        self.emailTextfield.text = ""
                        self.contentTextView.text = ""
                    })
                    
                    alert.addAction(action)
                    DispatchQueue.main.async {
                        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}
