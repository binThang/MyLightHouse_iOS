//
//  DoNotDisturbController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 31/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

class DoNotDisturbView: UIViewController {

    var startingTime: Int = 0
    var endingTime: Int = 0
    
    let clockImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "time"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "방해금지 시간대 설정"
        label.textColor = .black
        label.font = komaconFont(16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let border: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var startingUp: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "a_up"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleHourUp), for: .touchUpInside)
        return button
    }()
    
    lazy var startingDown: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "a_down"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleHourDown), for: .touchUpInside)
        return button
    }()
    
    lazy var endingUp: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "a_up"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleMinuteUp), for: .touchUpInside)
        return button
    }()
    
    lazy var endingDown: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "a_down"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleMinuteDown), for: .touchUpInside)
        return button
    }()
    
    let startingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = komaconFont(22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let endingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = komaconFont(22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let inBetweenView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "--"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let borderTwo: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let completButton: UIButton = {
        let button = UIButton()
        button.setTitle("설정완료", for: .normal)
        button.setTitleColor(UIColor.init(r: 19, g: 144, b: 255), for: .normal)
        button.titleLabel?.font = komaconFont(18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleComplete), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupComponents()
        startingLabel.text = String(format: "%02d", startingTime)
        endingLabel.text = String(format: "%02d", endingTime)
    }
}


















































































