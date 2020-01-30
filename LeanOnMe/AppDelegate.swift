//
//  AppDelegate.swift
//  LeanOnMe
//
//  Created by Justin Ji on 18/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        
        if let isSignedIn = UserDefaults.standard.object(forKey: "isSignedIn") as? Bool, isSignedIn == true {
            window?.rootViewController = UINavigationController(rootViewController: MainViewController())
        } else {
            window?.rootViewController = UINavigationController(rootViewController: LogInController())
        }

        if let font = UIFont(name: "Yanolja Yache", size: 18) {
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: font], for: .normal)
        }
        
        
        UINavigationBar.appearance().tintColor = .black
        FirebaseApp.configure()
        Messaging.messaging().delegate = self

        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()

        return true
    }
    
 
    func applicationDidBecomeActive(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
    }
    
  
    
    //MARK: 백그라운드에서 푸쉬 클릭해서 들어올때
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        guard let linkURL = userInfo["link"] as? String, let type = userInfo["text"], let idx = userInfo["idx"] as? String else { return }
        print(userInfo)
        NotificationCenter.default.post(name: NSNotification.Name("background"), object: nil, userInfo: ["url": linkURL, "type": type, "idx": idx])
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    //MARK: 알림 메세지를 받게 해주는 함수
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
    
    //MARK: Foreground에서 푸쉬와서 클릭할 때
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        
        guard let linkURL = userInfo["link"] as? String, let type = userInfo["text"], let idx = userInfo["idx"] as? String else { return }
        NotificationCenter.default.post(name: NSNotification.Name("foreground"), object: nil, userInfo: ["url": linkURL, "type": type, "idx": idx])
    }
}

    


extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
      
    }
}












































