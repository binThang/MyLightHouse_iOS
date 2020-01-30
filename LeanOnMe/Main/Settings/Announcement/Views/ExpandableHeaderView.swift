//
//  ExpandableHeaderView.swift
//  LeanOnMe
//
//  Created by Justin Ji on 31/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

protocol ExpandableHeaderViewDelegate {
    func willExpandSection(header: ExpandableHeaderView, section: Int)
}

class ExpandableHeaderView: UITableViewHeaderFooterView {
    
    var delegate: ExpandableHeaderViewDelegate?
    var section: Int!
    var isExpanded: Bool = false
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = komaconFont(17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = komaconFont(13)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var expandingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "a_down")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let border: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupComponents()
    self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction(gestureRecognizer:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(expandingImageView)
        addSubview(border)

        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            dateLabel.widthAnchor.constraint(equalToConstant: 200),
            dateLabel.heightAnchor.constraint(equalToConstant: 15),
            
            expandingImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            expandingImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            expandingImageView.widthAnchor.constraint(equalToConstant: 35),
            expandingImageView.heightAnchor.constraint(equalToConstant: 15),
            
            border.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
            border.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            border.trailingAnchor.constraint(equalTo: expandingImageView.trailingAnchor),
            border.heightAnchor.constraint(equalToConstant: 1),
            ])
    }
    
    @objc func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! ExpandableHeaderView
        delegate?.willExpandSection(header: self, section: cell.section)
    
        if isExpanded {
            expandingImageView.image = #imageLiteral(resourceName: "a_down")
            isExpanded = false
        } else {
            expandingImageView.image = #imageLiteral(resourceName: "a_up")
            isExpanded = true
        }
        
        
    }
    
    func customInit(title: String, subtitle: String, section: Int, delegate: ExpandableHeaderViewDelegate) {
        self.titleLabel.text = title
        self.dateLabel.text = subtitle
        self.section = section
        self.delegate = delegate
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.backgroundColor = UIColor.white
    }
    
}
























































