//
//  NotificationSettingsController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 31/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

class NotificationSettingsController: UIViewController {

    var isPushOn: Bool = true
    var isCommentOn: Bool = true
    var isSympathyOn: Bool = true
    var isNiceWordsOn: Bool = true
    var isVibrationOn: Bool = true

    let pushTitle: UILabel = {
        let label = UILabel()
        label.text = "푸시알림"
        label.font = komaconFont(15)
        label.textColor = UIColor.init(hexString: "2e2e2e")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var pushToggle: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "on"), for: .normal)
        button.addTarget(self, action: #selector(handlePush), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let borderOne: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "cccccc")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commentTitle: UILabel = {
        let label = UILabel()
        label.text = "댓글알림"
        label.font = komaconFont(15)
        label.textColor = UIColor.init(hexString: "2e2e2e")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var commentToggle: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "on"), for: .normal)
        button.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let borderTwo: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "cccccc")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sympathyTitle: UILabel = {
        let label = UILabel()
        label.text = "공감알림"
        label.font = komaconFont(15)
        label.textColor = UIColor.init(hexString: "2e2e2e")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var sympathyToggle: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "on"), for: .normal)
        button.addTarget(self, action: #selector(handleSympathy), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let borderThree: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "cccccc")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let niceWordsTitle: UILabel = {
        let label = UILabel()
        label.text = "명언알림"
        label.font = komaconFont(15)
        label.textColor = UIColor.init(hexString: "2e2e2e")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var niceWordsToggle: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "on"), for: .normal)
        button.addTarget(self, action: #selector(handleNiceWords), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let borderFour: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "cccccc")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let vibrationTitle: UILabel = {
        let label = UILabel()
        label.text = "진동설정"
        label.font = komaconFont(15)
        label.textColor = UIColor.init(hexString: "2e2e2e")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var vibrationToggle: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "on"), for: .normal)
         button.addTarget(self, action: #selector(handleVibration), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let borderFive: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "cccccc")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var doNotDisturbTitle: UILabel = {
        let label = UILabel()
        label.text = "방해금지 시간대 설정"
        label.font = komaconFont(15)
        label.backgroundColor = .white
        label.textColor = UIColor.init(hexString: "2e2e2e")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDoNotDisturb)))
        return label
    }()
    
    let borderSix: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "cccccc")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDimmedView)))
        return view
    }()
    
    let doNotDisturbView = DoNotDisturbView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vibration = UserDefaults.standard.object(forKey: "vibration") ?? "true"
        
        if let times = UserDefaults.standard.object(forKey: "DoNotDisturb") as? [Int] {
            doNotDisturbView.startingTime = times.first!
            doNotDisturbView.endingTime = times.last!
        }
        
        if vibration as! String == "true" {
            vibrationToggle.setBackgroundImage(#imageLiteral(resourceName: "on"), for: .normal)
        } else {
            vibrationToggle.setBackgroundImage(#imageLiteral(resourceName: "off"), for: .normal)
        }
        
        view.backgroundColor = .white
        setupNavigationBar(navigationController: navigationController!, navigationItem: navigationItem, titile: "")
        setNavitationItemTitle(navigationController: navigationController!, navigationItem: navigationItem, title: "설정")
        
        setupToggles()
        setupComponents()
        
        NotificationCenter.default.addObserver(self, selector: #selector(completeTimeSetUp(_:)), name: Notification.Name("timeSet"), object: nil)
    }

    @objc func completeTimeSetUp(_ notification: Notification) {
        handleDimmedView()
        let alert = UIAlertController(title: "설정 완료", message: "방해 금지 시간대가 설정되었습니다.", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}




































