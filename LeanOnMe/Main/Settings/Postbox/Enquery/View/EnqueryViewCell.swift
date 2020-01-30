//
//  EnqueryViewCell.swift
//  LeanOnMe
//
//  Created by Justin Ji on 01/11/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

class EnqueryViewCell: UICollectionViewCell, UITextViewDelegate
{
    let emailTitle: UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.font = komaconFont(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailTextfield: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "답변 받으실 메일 주소를 입력해주세요."
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
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "내용"
        label.font = komaconFont(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = komaconFont(12)
        textView.text = "문의 내용을 작성해 주세요."
        textView.contentInset = UIEdgeInsets(top: 15, left: 12, bottom: 0, right: 12)
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
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        setupComponents()
        contentTextView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
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
            contentTextView.heightAnchor.constraint(equalToConstant: 368),
            
            completeButton.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 20),
            completeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -19),
            completeButton.widthAnchor.constraint(equalToConstant: 79),
            completeButton.heightAnchor.constraint(equalToConstant: 30),
            ])
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.init(hexString: "C7C7CD") {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    @objc func handleComplete() {
        guard let email = emailTextfield.text, let enquery = contentTextView.text else { return }
        
        let isEmailValid = isValidEmailAddress(emailAddressString: email)
        
        if email == "" {
            let alert = UIAlertController(title: "입력 오류", message: "이메일을 적어주세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: { (_) in
                self.emailTextfield.becomeFirstResponder()
            })
            
            alert.addAction(action)
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            
        } else  if isEmailValid == false {
            let alert = UIAlertController(title: "입력 오류", message: "정확한 이메일 형식을 입력해 주세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: { (_) in
                self.emailTextfield.becomeFirstResponder()
            })
            
            alert.addAction(action)
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            
        } else if enquery == "" {
            let alert = UIAlertController(title: "입력 오류", message: "문의하실 내용을 적어주세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: { (_) in
                self.contentTextView.becomeFirstResponder()
            })
            
            alert.addAction(action)
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
        } else {
            
            APIService.instance.sendEnquery(withEmail: email, withEnquery: enquery) { (result) in
                if result == "success" {
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









































































