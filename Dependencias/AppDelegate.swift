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

        return true
    }
}

