//
//  HandlersForNewPageViewController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 06/11/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit
import WebKit
import Firebase

extension NewPageViewController {
    
  
    @objc func handleRightSwipe(gesture: UISwipeGestureRecognizer) {
        webView.evaluateJavaScript("viewnext('next')", completionHandler: nil)
    }
    
    @objc func handleLeftSwipe(gesture: UISwipeGestureRecognizer) {
        webView.evaluateJavaScript("viewnext('prev')", completionHandler: nil)
    }
    
    @objc func handleDismissKeyboard() {
        view.endEditing(true)
        webView.frame.origin.y = 0
        webView.frame = view.bounds
    }
    
    @objc func handleWebView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
        webView.frame.origin.y = 0
    }
    
    func dismissDimmedView() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.dimmedView.alpha = 0
            self.downloadShareView.frame = CGRect(x: 70, y: self.view.frame.height + 10, width: self.view.frame.width - 140, height: 0)
            self.commentViewController.view.alpha = 0
            self.view.endEditing(true)
        }) { (_) in
            
        }
    }
    @objc func handleDimmedView() {
        
        dismissDimmedView()
        isForCommentOfComment = false
        isForComment = false
        commentViewController.commentTextView.text = ""
    }
    
    //MARK: 글 수정하고 완료하는 함수
    @objc func handleComplete() {
        guard let categoryIdx = categoryIdx else { return }
        webView.evaluateJavaScript("update_board('\(categoryIdx)')", completionHandler: nil)
    }
    @objc func handleEditDelete() {
        showPopUpView()
    }
    
    @objc func handleSectionOne() {
        
        if isSwitched {
            //MARK: 글 수정
            setupBackButtonTitle(withNavigationController: navigationController!, withTitle: "")
            
            
            guard let idx = selectedIdx, let categoryIdx = categoryIdx else { return }
            let url = URL(string: baseURL+"/back/update/\(idx)")

            editMyPostVC.selectedIdx = idx
            editMyPostVC.urlToLoad = url
            editMyPostVC.categoryIdx = categoryIdx
            editMyPostVC.hashTagLabel.text = hashTagTitle
            self.navigationController?.popViewController(animated: true)
            self.navigationController?.present(editMyPostVC, animated: true, completion: nil)
            self.isSwitched = false
        } else {
            //MARK: 이미지 다운로드
            let urlStr = baseURL + "/public/uploads/mobile/image/\(imageName!)"
            showActionSheetForImageDownload(urlString: urlStr) { (result, img) in
                if result == "success" {
                    let alert = UIAlertController(title: "다운로드 성공", message: "이미지가 다운로드 되었습니다.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .default, handler: { (_) in
                        self.handleDimmedView()
                    })
                    
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    
                }
            }
            isSwitched = false
        }
    }
    
    @objc func handleCompeteEditing() {
        delegate?.WillGoBack(isFromNewPage: true)
    }
    
    @objc func handleSectionTwo() {
        
        if isSwitched {
            //MARK: 글 삭제
            let alert = UIAlertController(title: "글 삭제", message: "정말로 글을 삭제 하시겠습니까?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "예", style: .default, handler: { (_) in
                
                guard let idx = self.selectedIdx else { return }
                
                APIService.instance.deletePost(withIdx: idx, completion: { (result) in
                    if result == "true" {
                        self.isDeleted = true
                        self.delegate?.WillGoBack(isFromNewPage: false)
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                })
            })
            
            let noAction = UIAlertAction(title: "아니요", style: .cancel, handler: nil)
            alert.addAction(noAction)
            alert.addAction(yesAction)
            present(alert, animated: true, completion: nil)
            
            
        }  else {
            //MARK: 이미지 공유
            let urlStr = baseURL+"/public/uploads/mobile/image/\(imageName!)"
            showActionSheetForImageDownload(urlString: urlStr) { (result, image) in
                self.displayShareSheet(withContent: image)
                self.dismissDimmedView()
            }
        }
    }
    
    //댓글 또는 대댓글 수정창을 보여준다.
    @objc func handleCommentEdit() {
        
        if isForComment {
            //MARK: 댓글 수정
            self.dismissDimmedView()
            self.showCommentView()

        } else if isForCommentOfComment {
            //MARK: 댓글의 댓글을 수정
            self.dismissDimmedView()
            self.showCommentView()
        }
    }
    
    
    @objc func handleCommentDelete() {
       
        if isForComment {
            //MARK: 댓글 삭제
            guard let idx = self.commentIdx else { return }
            
            self.webView.evaluateJavaScript("del_reply('\(idx)')", completionHandler: { (_, _) in
                self.handleDimmedView()
              
            })
        } else if isForCommentOfComment {
            //MARK: 대댓글 삭제
            guard let idx = commentOfCommentIdx else { return }
            
            webView.evaluateJavaScript("del_rereply('\(idx)')", completionHandler: { (result, error) in
                self.handleDimmedView()
                
            })
            
        }
    }
    
   
    
    @objc func handleCompleteButton() {
        
        if isForComment {
            guard let comment = commentViewController.commentTextView.text, let idx = commentIdx else { return }
            
            webView.evaluateJavaScript("update_ios_reply('\(idx)', '\(comment)')") { (_, _) in
                self.dismissDimmedView()
                self.commentViewController.commentTextView.text = ""
                self.webView.reload()
                self.isForComment = false
            }
            
        } else if isForCommentOfComment {
            if let comment = commentViewController.commentTextView.text, let idx = commentOfCommentIdx  {
                
                webView.evaluateJavaScript("update_ios_reply('\(idx)', '\(comment)')") { (_, _) in
                    self.dismissDimmedView()
                    self.commentViewController.commentTextView.text = ""
                    self.webView.reload()
                    self.isForCommentOfComment = false
                }
            }
            
        }
       
    }
}




























































