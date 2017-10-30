//
//  AppDelegate.swift
//  ios-internship-notifications
//
//  Created by Kordian Ledzion on 17/10/2017.
//  Copyright © 2017 Tooploox Sp. z o.o. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = MainViewController()
        
        NotificationsGateway.registerCategories()
        NotificationsGateway.userNotificationCenter.delegate = self
        
        setUpNavigationBar()
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier ==
            NotificationsCategoriesActions.delayNotificationByFiveMinutes.actionIdentifier {
            let gateway = NotificationsGateway()
            let time = TimeInterval(integerLiteral: 5 * 60) //5 minutes = 5 * 60 seconds
            gateway.scheduleNotification(in: time, completion: nil)
        } else if response.actionIdentifier ==
            NotificationsCategoriesActions.displayMessage.actionIdentifier {
            guard response.isKind(of: UNTextInputNotificationResponse.self) else {
                return
            }
            let response = response as! UNTextInputNotificationResponse
            let viewModel = NotificationRespondViewModel(message: response.userText)
            let viewController = NotificationRespondViewController(viewModel: viewModel)
            window?.rootViewController?.present(viewController, animated: true, completion: nil)
        } else if response.actionIdentifier ==
            NotificationsCategoriesActions.delayNotificationWithNote.actionIdentifier {
            
        }
        completionHandler()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    private func setUpNavigationBar() {
        UIApplication.shared.isStatusBarHidden = true
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }

}
