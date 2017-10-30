//
//  NotificationsGateway.swift
//  ios-internship-notifications
//
//  Created by Kordian Ledzion on 17/10/2017.
//  Copyright © 2017 Tooploox Sp. z o.o. All rights reserved.
//

import UserNotifications
import Foundation

enum NotificationsCategoriesActions: String {

    case delayNotificationByFiveMinutes = "5_MINUTE_DELAY"
    case displayMessage = "DISPLAY_MESSAGE"
    case delayNotificationWithNote = "DELAY_WITH_NOTE"
    
    var actionIdentifier: String {
        return self.rawValue
    }

    fileprivate static let generalCategoryActions: [UNNotificationAction] = {
        return Array([
            UNNotificationAction(identifier: delayNotificationByFiveMinutes.actionIdentifier,
                                 title: "Delay for 5 minutes",
                                 options: UNNotificationActionOptions(rawValue: 0)),
            UNTextInputNotificationAction(identifier: NotificationsCategoriesActions.displayMessage.actionIdentifier,
                                          title: "Enter and display text",
                                          options: .foreground,
                                          textInputButtonTitle: "Send",
                                          textInputPlaceholder: "Enter text")
        ])
    }()
    
    fileprivate static let customInterfaceCategoryActions: [UNNotificationAction] = {
        return Array([
            UNTextInputNotificationAction(identifier: delayNotificationWithNote.actionIdentifier,
                                          title: "Delay with note",
                                          options: UNNotificationActionOptions(rawValue: 0),
                                          textInputButtonTitle: "Send",
                                          textInputPlaceholder: "Enter note")
        ])
    }()

}

enum NotificationsCategories: String {
    
    case general = "GENERAL"
    case customInterface = "CUSTOM_INTERFACE"
    
    var categoryIdentifier: String {
        return self.rawValue
    }
    
    fileprivate static let categories: Set<UNNotificationCategory> = {
        return Set([
            UNNotificationCategory(identifier: general.categoryIdentifier,
                                   actions: NotificationsCategoriesActions.generalCategoryActions,
                                   intentIdentifiers: [],
                                   options: UNNotificationCategoryOptions(rawValue: 0)),
            UNNotificationCategory(identifier: customInterface.categoryIdentifier,
                                   actions: NotificationsCategoriesActions.customInterfaceCategoryActions,
                                   intentIdentifiers: [],
                                   options: UNNotificationCategoryOptions(rawValue: 0))
        ])
    }()
}

class NotificationsGateway {
    
    static let userNotificationCenter = UNUserNotificationCenter.current()
    
    static func registerCategories() {
        userNotificationCenter.setNotificationCategories(NotificationsCategories.categories)
    }
    
    func scheduleNotification(in time: TimeInterval, completion: ((Bool) -> ())?) {
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = NotificationsCategories.general.categoryIdentifier
        content.title = "Intern Notify reminder!"
        content.body = "Do you remember? You wanted me to remind you right now!"
        
        let url = Bundle.main.url(forResource: "kotki", withExtension: "png")!
        let attachement = try! UNNotificationAttachment(identifier: UUID().uuidString, url: url, options: nil)
        
        content.attachments.append(attachement)
        content.sound = UNNotificationSound(named: "happyBork.aiff")
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            guard let error = error else {
                completion?(true)
                return
            }
            print(error.localizedDescription)
            completion?(false)
        }
    }
    
    func scheduleCustomInterfaceNotification(in time: TimeInterval, completion: ((Bool) -> ())?) {
        
    }
    
    func requestPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { permissionGranted, error in
            if permissionGranted {
                //TODO: do something on access granted
            } else {
                guard let error = error else {
                    return
                }
                print(error.localizedDescription)
            }
        }
    }
    
}
