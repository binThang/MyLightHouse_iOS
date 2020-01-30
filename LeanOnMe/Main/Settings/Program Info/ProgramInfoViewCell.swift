//
//  ProgramInfoViewCell.swift
//  LeanOnMe
//
//  Created by Justin Ji on 05/11/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

class ProgramInfoViewCell: UITableViewCell {

    let background: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "f3f3f3")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let customTextView: UITextView = {
        let textView = UITextView()
        textView.font = komaconFont(12)
        textView.textColor = UIColor.init(hexString: "616161")
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
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
        addSubview(customTextView)
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: self.topAnchor),
            background.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            background.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
            background.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            customTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            customTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            customTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -28),
            customTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
            ])
        
        
    }
    
}
