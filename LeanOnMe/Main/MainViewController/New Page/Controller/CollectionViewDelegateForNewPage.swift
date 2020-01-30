//
//  CollectionViewDelegateForNewPage.swift
//  LeanOnMe
//
//  Created by Justin Ji on 27/12/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

extension NewPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forDownloadShare.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PopUpViewCell
        
        if isSwitched {
            if indexPath.row == 0 {
                cell.titleLabel.isUserInteractionEnabled = true
                cell.titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSectionOne)))
            } else if indexPath.row == 1 {
                cell.titleLabel.isUserInteractionEnabled = true
                cell.titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSectionTwo)))
            }
            
            cell.downloadShare = forEditDelete[indexPath.row]
            
        } else {
            if indexPath.row == 0 {
                cell.titleLabel.isUserInteractionEnabled = true
                cell.titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSectionOne)))
            } else if indexPath.row == 1 {
                cell.titleLabel.isUserInteractionEnabled = true
                cell.titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSectionTwo)))
            }
            
            cell.downloadShare = forDownloadShare[indexPath.row]
        }
        
        if isForCommentOfComment {
            if indexPath.row == 0 {
                cell.titleLabel.isUserInteractionEnabled = true
                cell.titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCommentEdit)))
            }
            
            if indexPath.row == 1 {
                cell.titleLabel.isUserInteractionEnabled = true
                cell.titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCommentDelete)))
            }
            
            cell.downloadShare = forComment[indexPath.row]
        }
        
        if isForComment {
            if indexPath.row == 0 {
                cell.titleLabel.isUserInteractionEnabled = true
                cell.titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCommentEdit)))
            } else if indexPath.row == 1 {
                cell.titleLabel.isUserInteractionEnabled = true
                cell.titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCommentDelete)))
            }
            
            cell.downloadShare = forComment[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width - 140, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
