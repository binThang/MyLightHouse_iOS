//
//  VerifyForPassword.swift
//  LeanOnMe
//
//  Created by Justin Ji on 25/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit


class VerifyForPassword: UIViewController, UITextFieldDelegate {
    
    var randomNumber: String?
    var seconds = 180
    var timer = Timer()
    var textfieldArray = [UITextField]()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("✕", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.titleLabel?.font = notoSansUIBold(25)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "인증번호"
        label.font = notoSansUIBold(27)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = notoSansUIRegular(15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var numberBoxOne: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont.systemFont(ofSize: 30)
        textfield.textColor = UIColor.init(hexString: "#ffb445")
        textfield.textAlignment = .center
        textfield.keyboardType = .numberPad
        textfield.layer.borderColor = UIColor.init(hexString: "#ffb445").cgColor
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textfield.leftView = paddingView
        textfield.layer.borderWidth = 1
        textfield.isSecureTextEntry = true
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.addTarget(self, action: #selector(handleBoxOne), for: .editingDidBegin)
        return textfield
    }()
    
    lazy var numberBoxTwo: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont.systemFont(ofSize: 30)
        textfield.textColor = UIColor.init(hexString: "#ffb445")
        textfield.textAlignment = .center
        textfield.keyboardType = .numberPad
        textfield.layer.borderColor = UIColor.init(hexString: "#ffb445").cgColor
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textfield.leftView = paddingView
        textfield.layer.borderWidth = 1
        textfield.isSecureTextEntry = true
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    lazy var numberBoxThree: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont.systemFont(ofSize: 30)
        textfield.textColor = UIColor.init(hexString: "#ffb445")
        textfield.textAlignment = .center
        textfield.keyboardType = .numberPad
        textfield.layer.borderColor = UIColor.init(hexString: "#ffb445").cgColor
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textfield.leftView = paddingView
        textfield.layer.borderWidth = 1
        textfield.isSecureTextEntry = true
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    lazy var numberBoxFour: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont.systemFont(ofSize: 30)
        textfield.textColor = UIColor.init(hexString: "#ffb445")
        textfield.textAlignment = .center
        textfield.keyboardType = .numberPad
        textfield.layer.borderColor = UIColor.init(hexString: "#ffb445").cgColor
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        textfield.leftView = paddingView
        textfield.layer.borderWidth = 1
        textfield.isSecureTextEntry = true
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.addTarget(self, action: #selector(handleBoxFour), for: .editingDidEnd)
        
        return textfield
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberBoxOne.becomeFirstResponder()
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        numberBoxOne.delegate = self
        numberBoxTwo.delegate = self
        numberBoxThree.delegate = self
        numberBoxFour.delegate = self
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissKeyboard)))
        view.backgroundColor = .white
        setupComponents()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
        
        
        textfieldArray.append(contentsOf: [numberBoxOne, numberBoxTwo, numberBoxThree, numberBoxFour])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false

    }
    
    @objc func handleTimer() {
        
        if seconds < 1 {
            let alert = UIAlertController(title: "로그인 성공", message: "메인 페이지로 이동합니다.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        } else {
            seconds -= 1
            timeLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    
    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time)/60%60
        let seconds = Int(time)%60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    func setupComponents() {
        view.addSubview(cancelButton)
        view.addSubview(titleLabel)
        view.addSubview(timeLabel)
        view.addSubview(numberBoxTwo)
        view.addSubview(numberBoxOne)
        view.addSubview(numberBoxThree)
        view.addSubview(numberBoxFour)
        
        NSLayoutConstraint.activate([
            
            cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            cancelButton.widthAnchor.constraint(equalToConstant: 20),
            cancelButton.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            timeLabel.widthAnchor.constraint(equalToConstant: 200),
            timeLabel.heightAnchor.constraint(equalToConstant: 30),
            
            numberBoxTwo.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
            numberBoxTwo.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -5),
            numberBoxTwo.widthAnchor.constraint(equalToConstant: 50),
            numberBoxTwo.heightAnchor.constraint(equalToConstant: 50),
            
            numberBoxOne.topAnchor.constraint(equalTo: numberBoxTwo.topAnchor),
            numberBoxOne.trailingAnchor.constraint(equalTo: numberBoxTwo.leadingAnchor, constant: -10),
            numberBoxOne.widthAnchor.constraint(equalToConstant: 50),
            numberBoxOne.heightAnchor.constraint(equalToConstant: 50),
            
            numberBoxThree.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
            numberBoxThree.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5),
            numberBoxThree.widthAnchor.constraint(equalToConstant: 50),
            numberBoxThree.heightAnchor.constraint(equalToConstant: 50),
            
            numberBoxFour.topAnchor.constraint(equalTo: numberBoxTwo.topAnchor),
            numberBoxFour.leadingAnchor.constraint(equalTo: numberBoxThree.trailingAnchor, constant: 10),
            numberBoxFour.widthAnchor.constraint(equalToConstant: 50),
            numberBoxFour.heightAnchor.constraint(equalToConstant: 50),
            ])
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if numberBoxOne.text?.count == 1 {
            numberBoxOne.resignFirstResponder()
            numberBoxTwo.becomeFirstResponder()
        }
        
        if numberBoxTwo.text?.count == 1 {
            numberBoxTwo.resignFirstResponder()
            numberBoxThree.becomeFirstResponder()
        }
        
        if numberBoxThree.text?.count == 1 {
            numberBoxThree.resignFirstResponder()
            numberBoxFour.becomeFirstResponder()
        }
        
        if numberBoxFour.text?.count == 1 {
            numberBoxFour.resignFirstResponder()
            view.endEditing(true)
        }
        
        return true
    }
    
    @objc func handleBoxOne() {
        numberBoxOne.text = ""
        numberBoxTwo.text = ""
        numberBoxThree.text = ""
        numberBoxFour.text = ""
    }
    
    @objc func handleBoxFour() {
        
        guard let one = numberBoxOne.text, let two = numberBoxTwo.text, let three = numberBoxThree.text, let four = numberBoxFour.text else { return }
        let typedNumbers = "\(one)\(two)\(three)\(four)"
        print(typedNumbers)
        
        //받은 인증번호와 입력한 번호가 같을때
        if randomNumber == typedNumbers {
            let alert = UIAlertController(title: "인증성공", message: "인증에 성공하였습니다.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
                
            let changePasswordViewController = ChangePasswordViewController()
            self.navigationController?.pushViewController(changePasswordViewController, animated: true)
         
            })
            
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "인증실패", message: "입력하신 번호가 일치하지 않습니다.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
                self.handleBoxOne()
                self.numberBoxOne.becomeFirstResponder()
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    @objc func handleDismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func handleCancel() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    
}
