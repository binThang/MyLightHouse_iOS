//
//  MenuItemTitleCell.swift
//  LeanOnMe
//
//  Created by Justin Ji on 30/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

class MenuItemTitleCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            titleLabel.textColor = isHighlighted ? UIColor.white : UIColor.init(hexString: "063251")
        }
    }
    
    var menuItem: MenuItem? {
        didSet {
           titleLabel.text = menuItem?.title
        }
    }
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = komaconFont(16)
        label.textColor = UIColor.init(hexString: "063251")
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
        addConstraintsWithFormat(format: "V:|[v0(30)]|", views: titleLabel)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






























































