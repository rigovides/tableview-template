//
//  AppDelegate.swift
//  Dependencias
//
//  Created by Rigoberto Antonio Vides Rodriguez on 8/3/19.
//  Copyright © 2019 Rigoberto Antonio Vides Rodriguez. All rights reserved.
//e

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let center = UNUserNotificationCenter.current()
        // Pedimos permiso para alerts y sonidos.
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            // Habilitar o deshabilitar
            guard granted == true else {
                //present denied
                DispatchQueue.main.async {
                    let vc = self.window?.rootViewController?.storyboard?.instantiateViewController(withIdentifier: "deniedID")
                    self.window?.rootViewController = vc
                }
                return
            }
        }

        UNUserNotificationCenter.current().delegate = self

        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.window?.rootViewController?.show(alert, sender: nil)
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        self.showAlert(title: "Time to deep breath", message: "10 seconds have passed 💙")
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        self.showAlert(title: "Welcome back", message: "Now breath...")
    }
}

