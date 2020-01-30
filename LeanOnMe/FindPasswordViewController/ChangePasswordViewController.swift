//
//  ChangePasswordViewController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 19/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("✕", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 재설정"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let selfMadeNavigationBar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let newPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "새 비밀번호"
        label.textColor = UIColor.init(hexString: "#131215")
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.font = notoSansUIRegular(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let newPasswordTextfield: UITextField = {
        let textfield = UITextField()
        textfield.font = notoSansUIRegular(14)
        textfield.isSecureTextEntry = true
        textfield.attributedPlaceholder = NSAttributedString(string: "새로 설정할 비밀번호를 입력해 주세요.", attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(hexString: "#131215").withAlphaComponent(0.3), NSAttributedStringKey.font: notoSansUIRegular(14)])
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let newPasswordBottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "#131215")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let doubleCheckLabel: UILabel = {
        let label = UILabel()
        label.text = "새 비밀번호 확인"
        label.textColor = UIColor.init(hexString: "#131215")
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.font = notoSansUIRegular(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let doubleCheckTextfield: UITextField = {
        let textfield = UITextField()
        textfield.font = notoSansUIRegular(14)
        textfield.isSecureTextEntry = true
        textfield.attributedPlaceholder = NSAttributedString(string: "한번 더 입력해 주세요.", attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(hexString: "#131215").withAlphaComponent(0.3), NSAttributedStringKey.font: notoSansUIRegular(14)])
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let doubleCheckBottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "#131215")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(UIColor.init(hexString: "#b9b9b9"), for: .normal)
        button.titleLabel?.font = notoSansUIRegular(14)
        button.layer.borderColor = UIColor.init(hexString: "#bdbdbd").cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleComplete), for: .touchUpInside)
        return button
    }()
    
    lazy var gradientView: CAGradientLayer = {
        let gradientx = CAGradientLayer()
        gradientx.colors = [UIColor.init(hexString: "fbac35").cgColor, UIColor.init(hexString: "fbd135").cgColor]
        gradientx.startPoint = CGPoint(x: 0, y: 1)
        gradientx.endPoint = CGPoint(x: 0.8, y: 1)
        gradientx.frame = completeButton.bounds
        gradientx.cornerRadius = completeButton.layer.cornerRadius
        return gradientx
    }()
    
    lazy var verificationSuccess: UILabel = {
        let label = UILabel(frame: gradientView.bounds)
        label.text = "변경완료"
        label.textAlignment = .center
        label.textColor = .white
        label.font = notoSansUIRegular(14)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        setupComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationController?.navigationBar.isHidden = true
    }
    

    func setupComponents() {
        
        view.addSubview(selfMadeNavigationBar)
        view.addSubview(titleLabel)
        view.addSubview(cancelButton)
        
        view.addSubview(newPasswordLabel)
        view.addSubview(newPasswordTextfield)
        view.addSubview(newPasswordBottomLine)
        
        view.addSubview(doubleCheckLabel)
        view.addSubview(doubleCheckTextfield)
        view.addSubview(doubleCheckBottomLine)
        view.addSubview(completeButton)
        
        NSLayoutConstraint.activate([
            
            selfMadeNavigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            selfMadeNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selfMadeNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            selfMadeNavigationBar.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.topAnchor.constraint(equalTo: selfMadeNavigationBar.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: selfMadeNavigationBar.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: selfMadeNavigationBar.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: selfMadeNavigationBar.bottomAnchor),
            
            cancelButton.topAnchor.constraint(equalTo: selfMadeNavigationBar.topAnchor, constant: 30),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            cancelButton.widthAnchor.constraint(equalToConstant: 20),
            cancelButton.heightAnchor.constraint(equalToConstant: 20),
            
            
            newPasswordLabel.topAnchor.constraint(equalTo: selfMadeNavigationBar.bottomAnchor, constant: 60),
            newPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            newPasswordLabel.widthAnchor.constraint(equalToConstant: 60),
            newPasswordLabel.heightAnchor.constraint(equalToConstant: 15),
            
            newPasswordTextfield.topAnchor.constraint(equalTo: newPasswordLabel.bottomAnchor, constant: 9),
            newPasswordTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 54),
            newPasswordTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -54),
            newPasswordTextfield.heightAnchor.constraint(equalToConstant: 30),
            
            newPasswordBottomLine.topAnchor.constraint(equalTo: newPasswordTextfield.bottomAnchor),
            newPasswordBottomLine.leadingAnchor.constraint(equalTo: newPasswordTextfield.leadingAnchor),
            newPasswordBottomLine.trailingAnchor.constraint(equalTo: newPasswordTextfield.trailingAnchor),
            newPasswordBottomLine.heightAnchor.constraint(equalToConstant: 1),
            
            doubleCheckLabel.topAnchor.constraint(equalTo: newPasswordBottomLine.bottomAnchor, constant: 33),
            doubleCheckLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            doubleCheckLabel.widthAnchor.constraint(equalToConstant: 90),
            doubleCheckLabel.heightAnchor.constraint(equalToConstant: 15),
            
            doubleCheckTextfield.topAnchor.constraint(equalTo: doubleCheckLabel.bottomAnchor, constant: 9),
            doubleCheckTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 54),
            doubleCheckTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -54),
            doubleCheckTextfield.heightAnchor.constraint(equalToConstant: 30),
            
            doubleCheckBottomLine.topAnchor.constraint(equalTo: doubleCheckTextfield.bottomAnchor),
            doubleCheckBottomLine.leadingAnchor.constraint(equalTo: doubleCheckTextfield.leadingAnchor),
            doubleCheckBottomLine.trailingAnchor.constraint(equalTo: doubleCheckTextfield.trailingAnchor),
            doubleCheckBottomLine.heightAnchor.constraint(equalToConstant: 1),
           
            completeButton.topAnchor.constraint(equalTo: doubleCheckBottomLine.bottomAnchor, constant: 16),
            completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -43),
            completeButton.widthAnchor.constraint(equalToConstant: 79),
            completeButton.heightAnchor.constraint(equalToConstant: 31),
            ])
    }
    
    @objc func handleComplete() {
        
        if (newPasswordTextfield.text?.isEmpty)! || (doubleCheckTextfield.text?.isEmpty)! {
            let alert = UIAlertController(title: "입력오류", message: "비밀번호를 입력해 주세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
               
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
        if newPasswordTextfield.text == doubleCheckTextfield.text {
            
            guard let newPassword = newPasswordTextfield.text, let username = UserDefaults.standard.object(forKey: "username") as? String else {
                return }
            
            
            APIService.instance.changePassword(withUsername: username, withPassword: newPassword, completionHandler: { (result) in
                
                if result == "true" {
                    self.addGradientColour(withButton: self.completeButton)
                    let alert = UIAlertController(title: "비밀번호 변경 성공", message: "비밀번호가 성공적으로 변경되었습니다.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
                    self.navigationController?.popToRootViewController(animated: true)
                    })
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                   
                }
            })
            
        } else {
            let alert = UIAlertController(title: "입력오류", message: "비밀번호가 일치하지 않습니다.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
                
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    @objc func handleCancel() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func addGradientColour(withButton button: UIButton) {
        
        button.layer.addSublayer(gradientView)
        button.layer.masksToBounds = false
        button.addSubview(verificationSuccess)
        button.layer.borderWidth = 0
    }
    
    func removeGradientColour() {
        completeButton.layer.borderWidth = 1
        gradientView.removeFromSuperlayer()
        verificationSuccess.removeFromSuperview()
    }

}




















































































