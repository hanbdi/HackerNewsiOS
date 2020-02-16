//
//  AppDelegate.swift
//  HackerNewsiOS
//
//  Created by Dang Duong Hung on 16/2/20.
//  Copyright © 2020 Dang Duong Hung. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupAppearance()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = initRootViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

}

// MARK: private methods

private extension AppDelegate {
    func initRootViewController() -> UIViewController {
        return UINavigationController(rootViewController: TopStoriesViewController())
    }
    
    func setupAppearance() {
        UINavigationBar.appearance().barTintColor = .navigationBar
    }
}
