//
//  CollectionViewDelegates.swift
//  LeanOnMe
//
//  Created by Justin Ji on 15/12/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! HashTagViewCell
        cell.nameLabel.text = categoryArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0: refreshMainWebView(withIdx: "1")
        case 1: refreshMainWebView(withIdx: "2")
        case 2: refreshMainWebView(withIdx: "3")
        case 3: refreshMainWebView(withIdx: "4")
        case 4: refreshMainWebView(withIdx: "5")
        case 5: refreshMainWebView(withIdx: "6")
        case 6: refreshMainWebView(withIdx: "7")
        case 7: refreshMainWebView(withIdx: "8")
        case 8: refreshMainWebView(withIdx: "9")
        case 9: refreshMainWebView(withIdx: "10")
        default:
            return
        }
    }
    
}
