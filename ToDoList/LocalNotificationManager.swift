//
//  LocalNotificationManager.swift
//  ToDoList
//
//  Created by Christopher Greene on 3/9/20.
//  Copyright © 2020 Christopher Greene. All rights reserved.
//

import UIKit
import UserNotifications

struct LocalNotificationManager {
    static func authorizeLocalNotifications(viewController: UIViewController) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            guard error == nil else {
                print("ERROR: \(error!.localizedDescription)")
                return
            }
            if granted {
                print("Notifications authorization granted.")
            } else {
                print("User has denied notifications.")
                DispatchQueue.main.async {
                    viewController.oneButtonAlert(title: "User Has Not Allowed Notifications", message: "To receive notifications, enable notifications within settings.")
                }
            }
        }
    }
    
    static func isAuthorized(completed: @escaping (Bool)->() ) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            guard error == nil else {
                print("ERROR: \(error!.localizedDescription)")
                completed(false)
                return
            }
            if granted {
                print("Notifications authorization granted.")
                completed(true)

            } else {
                print("User has denied notifications.")
                completed(false)

                
            }
        }
    }
    
    static func setCalendarNotification(title: String, subtitle: String, body: String, badgeNumber: NSNumber?, sound: UNNotificationSound?, date: Date) -> String {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = sound
        content.badge = badgeNumber
        
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        dateComponents.second = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let notificationID = UUID().uuidString
        let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription) Adding notification request failed.")
            } else {
                print("Notification scheduled, \(notificationID), title: \(content.title)")
            }
        }
        return notificationID
    }
}
