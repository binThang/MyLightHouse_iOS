//
//  ExpandableHeaderViewForProgramInfo.swift
//  LeanOnMe
//
//  Created by Justin Ji on 01/11/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

protocol ExpandableHeaderViewForProgramInfoDelegate {
    func willExpandSection(header: ExpandableHeaderViewForProgramInfo, section: Int)
}

class ExpandableHeaderViewForProgramInfo: UITableViewHeaderFooterView {
    var delegate: ExpandableHeaderViewForProgramInfoDelegate?
    var section: Int!
    var isExpanded: Bool = false
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = komaconFont(14)
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
        addSubview(expandingImageView)
        addSubview(border)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 250),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
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
        let cell = gestureRecognizer.view as! ExpandableHeaderViewForProgramInfo
        delegate?.willExpandSection(header: self, section: cell.section)
        
        if isExpanded {
            expandingImageView.image = #imageLiteral(resourceName: "a_down")
            textLabel?.isHidden = true
            isExpanded = false
        } else {
            expandingImageView.image = #imageLiteral(resourceName: "a_up")
            textLabel?.isHidden = true
            isExpanded = true
        }
        
        
    }
    
    func customInit(title: String, section: Int, delegate: ExpandableHeaderViewForProgramInfoDelegate) {
        self.titleLabel.text = title
       
        self.section = section
        self.delegate = delegate
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.backgroundColor = UIColor.white
    }
    
}
