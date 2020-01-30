//
//  Components().swift
//  LeanOnMe
//
//  Created by Justin Ji on 02/11/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension MainViewController {
    func setupComponents() {
        
        view.addSubview(mainLogo)
        view.addSubview(resultTitle)
        view.addSubview(hashTagLabel)
        view.addSubview(hashTagButton)
        view.addSubview(sideMenuButton)
        view.addSubview(previousButton)
        view.addSubview(previousForSeach)
        view.addSubview(cancelButton)
        view.addSubview(disappearPicturesButton)
        view.addSubview(completeButton)
        view.addSubview(searchButton)
        view.addSubview(searchBar)
        view.addSubview(floatingButton)
        view.addSubview(deleteSearchTermsButton)
        
        
      
        
        NSLayoutConstraint.activate([
            
            mainLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
            mainLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLogo.widthAnchor.constraint(equalToConstant: 150),
            mainLogo.heightAnchor.constraint(equalToConstant: 34),
            
            
            sideMenuButton.centerYAnchor.constraint(equalTo: mainLogo.centerYAnchor),
            sideMenuButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
            sideMenuButton.widthAnchor.constraint(equalToConstant: 39),
            sideMenuButton.heightAnchor.constraint(equalToConstant: 29),
            
            previousButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
            previousButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
            previousButton.widthAnchor.constraint(equalToConstant: 39),
            previousButton.heightAnchor.constraint(equalToConstant: 30),
            
            previousForSeach.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
            previousForSeach.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
            previousForSeach.widthAnchor.constraint(equalToConstant: 39),
            previousForSeach.heightAnchor.constraint(equalToConstant: 30),
            
            resultTitle.centerYAnchor.constraint(equalTo: previousButton.centerYAnchor, constant: 2),
            resultTitle.leadingAnchor.constraint(equalTo: previousButton.trailingAnchor),
            resultTitle.widthAnchor.constraint(equalToConstant: 200),
            resultTitle.heightAnchor.constraint(equalToConstant: 23),
            
            hashTagLabel.centerYAnchor.constraint(equalTo: previousButton.centerYAnchor),
            hashTagLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hashTagLabel.widthAnchor.constraint(equalToConstant: 40),
            hashTagLabel.heightAnchor.constraint(equalToConstant: 34),
            
            hashTagButton.centerYAnchor.constraint(equalTo: previousButton.centerYAnchor),
            hashTagButton.leadingAnchor.constraint(equalTo: hashTagLabel.trailingAnchor),
            hashTagButton.widthAnchor.constraint(equalToConstant: 30),
            hashTagButton.heightAnchor.constraint(equalToConstant: 30),
            
            cancelButton.centerYAnchor.constraint(equalTo: previousButton.centerYAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
            cancelButton.widthAnchor.constraint(equalToConstant: 30),
            cancelButton.heightAnchor.constraint(equalToConstant: 30),
            
            disappearPicturesButton.centerYAnchor.constraint(equalTo: previousButton.centerYAnchor),
            disappearPicturesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
            disappearPicturesButton.widthAnchor.constraint(equalToConstant: 20),
            disappearPicturesButton.heightAnchor.constraint(equalToConstant: 20),
            
            completeButton.centerYAnchor.constraint(equalTo: previousButton.centerYAnchor),
            completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
            completeButton.widthAnchor.constraint(equalToConstant: 50),
            completeButton.heightAnchor.constraint(equalToConstant: 15),
            
            searchButton.centerYAnchor.constraint(equalTo: mainLogo.centerYAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -13),
            searchButton.widthAnchor.constraint(equalToConstant: 30),
            searchButton.heightAnchor.constraint(equalToConstant: 27),
            
            searchBar.centerYAnchor.constraint(equalTo: previousButton.centerYAnchor),
            searchBar.leadingAnchor.constraint(equalTo: sideMenuButton.trailingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 35),
            
            deleteSearchTermsButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            deleteSearchTermsButton.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -5),
            deleteSearchTermsButton.widthAnchor.constraint(equalToConstant: 30),
            deleteSearchTermsButton.heightAnchor.constraint(equalToConstant: 30),
            
            floatingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            floatingButton.widthAnchor.constraint(equalToConstant: 60),
            floatingButton.heightAnchor.constraint(equalToConstant: 60),
            
        
            ])
    }
}
