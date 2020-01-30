//
//  AnnouncementCell.swift
//  LeanOnMe
//
//  Created by Justin Ji on 31/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

class AnnouncementCell: UITableViewCell {
    
    let background: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let customeLabel: UILabel = {
        let label = UILabel()
        label.font = komaconFont(15)
        label.numberOfLines = 200
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setupComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func setupComponents() {
        addSubview(background)
        addSubview(customeLabel)
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: self.topAnchor),
            background.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            background.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
            background.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            customeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            customeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            customeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -28),
            customeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
            ])
        
        
    }
  
}






































