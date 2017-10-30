//
//  NotificationViewController.swift
//  NotificationContentExtension
//
//  Created by Kordian Ledzion on 20/10/2017.
//  Copyright © 2017 Tooploox Sp. z o.o. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        //self.label?.text = notification.request.content.body
        print("YEAH")
    }

}
