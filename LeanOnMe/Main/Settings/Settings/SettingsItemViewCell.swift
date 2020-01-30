//
//  SettingsItemViewCell.swift
//  LeanOnMe
//
//  Created by Justin Ji on 30/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

class SettingsItemViewCell: UICollectionViewCell {
    
//    override var isHighlighted: Bool {
//        didSet {
//            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
//            titleLabel.textColor = isHighlighted ? UIColor.white : UIColor.init(hexString: "063251")
//        }
//    }
    
    var settingItem: SettingsItem?
    {
        didSet
        {
            titleLabel.text = settingItem?.title
        }
    }
    
    var titleLabel: UILabel =
    {
        let label = UILabel()
        label.font = komaconFont(15)
        label.textColor = UIColor.init(hexString: "2e2e2e")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let border: UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "cccccc")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(border)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -2),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -22),
            
            border.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            border.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22),
            border.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -22),
            border.heightAnchor.constraint(equalToConstant: 1)
            ])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
