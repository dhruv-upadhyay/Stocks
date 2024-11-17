//
//  AppDelegate.swift
//  Stocks
//
//  Created by Dhruv Upadhyay on 15/11/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Set up the root view controller
        let rootViewController = StocksListVC() // Replace with your main view controller class
        rootViewController.view.backgroundColor = .white // Optional background color for testing
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

