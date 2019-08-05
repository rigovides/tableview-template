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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkPermissions()
    }
    
    @IBAction func remindButtonAction(_ sender: Any) {
    }

    private func checkPermissions() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { (settings) in
            guard settings.authorizationStatus == .authorized else {
                let alert = UIAlertController(title: "Enable Notifications", message: "Please enable notifications in app settings to continue", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.show(alert, sender: nil)
                return
            }
            if settings.alertSetting == .enabled {
                self.remindButton.isEnabled = true// delivery deseable
            }
            else {
                // configuración específica
            }
        }
    }
}
