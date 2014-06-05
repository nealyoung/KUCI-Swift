//
//  AppDelegate.swift
//  KUCI
//
//  Created by Nealon Young on 6/2/14.
//  Copyright (c) 2014 Nealon Young. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        self.customizeAppearance()
        return true
    }

    func customizeAppearance() {
        window!.tintColor = UIColor.whiteColor()
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        UINavigationBar.appearance().barTintColor = UIColor(white: 0.15, alpha: 1.0)
        UITabBar.appearance().barTintColor = UIColor(white: 0.15, alpha: 1.0)
        UIToolbar.appearance().barTintColor = UIColor(white: 0.15, alpha: 1.0)
        
        var navigationBarTitleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(),
                                                NSFontAttributeName: UIFont.semiboldApplicationFont(19.0)]
        UINavigationBar.appearance().titleTextAttributes = navigationBarTitleTextAttributes
        
        var barButtonItemTitleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(),
                                                NSFontAttributeName: UIFont.applicationFont(17.0)]
        UIBarButtonItem.appearance().setTitleTextAttributes(barButtonItemTitleTextAttributes, forState: UIControlState.Normal)
    }
}
