//
//  NotificationService.swift
//  NotificationServiceExtension
//
//  Created by Justin Ji on 19/12/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UserNotifications

@available(iOS 10.0, *)
open class DownloadManager: NSObject {
    
    open class func image(_ URLString: String) -> String? {
        let componet = URLString.components(separatedBy: "/")
        
        if let fileName = componet.last {
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            if let documentsPath = paths.first {
                let filePath = documentsPath.appending("/" + fileName)
                if let imageURL = URL(string: URLString) {
                    do {
                        let data = try NSData(contentsOf: imageURL, options: NSData.ReadingOptions(rawValue: 0))
                        
                        if data.write(toFile: filePath, atomically: true) {
                            return filePath
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }
        return nil
    }
}

@available(iOS 10.0, *)
class NotificationService: UNNotificationServiceExtension {
    
    let domain = "http://13.124.110.195"
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        
        self.contentHandler = contentHandler
        
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            
            // Modify the notification content here...
            if let imageURLString = bestAttemptContent.userInfo["image"] as? String {
                if let imagePath = DownloadManager.image(imageURLString) {
                    let imageURL = URL(fileURLWithPath: imagePath)
                    do {
                        let attach = try UNNotificationAttachment(identifier: "image", url: imageURL, options: nil)
                        bestAttemptContent.attachments = [attach]
                        
                    } catch {
                        print(error)
                    }
                } else {
                    bestAttemptContent.body = "이미지 데이터화 실패"
                }
            }
            contentHandler(bestAttemptContent)
        }
        
    }
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
}
