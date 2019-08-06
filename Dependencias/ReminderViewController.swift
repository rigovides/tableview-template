//
//  ReminderViewController.swift
//  Dependencias
//
//  Created by Rigoberto Antonio Vides Rodriguez on 8/5/19.
//  Copyright © 2019 Rigoberto Antonio Vides Rodriguez. All rights reserved.
//

import UIKit
import UserNotifications

class ReminderViewController: UIViewController {

    @IBOutlet weak var remindButton: UIButton!
    
    @IBAction func remindButtonAction(_ sender: Any) {
        self.sendNotificationRequest(in: 10)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkPermissions()
    }

    private func sendNotificationRequest(in seconds: Int) {
        let date = Date(timeIntervalSinceNow:10)
        let components = Calendar.current.dateComponents([.weekday, .hour, .minute, .second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let content = self.createContent(title: "Time to deep breath", body: "\(seconds) seconds have passed 💙")

        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content, trigger: trigger)

        self.registerRequest(for: request)
    }

    private func createContent(title: String, body: String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        return content
    }

    private func registerRequest(for request: UNNotificationRequest) {
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                // Handle any errors.
            }
        }

    }

    private func checkPermissions() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
            case .authorized:
                self.enableRemindButton()
            default:
                self.showAlert()
            }
        }
    }

    private func showAlert() {
        let alert = UIAlertController(title: "Enable Notifications", message: "Please enable notifications in app settings to continue", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.show(alert, sender: nil)
    }

    private func enableRemindButton() {
        DispatchQueue.main.async {
            self.remindButton.isEnabled = true
        }
    }
}
