//
//  TestingAppDelegate.swift
//  WGTest
//
//  Created by Denis Gavrilenko on 12/3/16.
//  Copyright © 2016 DreamTeam. All rights reserved.
//

import UIKit

class TestingAppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}
