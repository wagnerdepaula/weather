//
//  AppDelegate.swift
//  weather
//
//  Created by Wagner De Paula on 7/21/18.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = Color.white
        UINavigationBar.appearance().barTintColor = Color.blue
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: Color.white,
                                                            NSAttributedStringKey.font: Font.bold.of(size: 18)]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: Font.regular.of(size: 16)], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: Font.regular.of(size: 16)], for: .selected)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: Font.regular.of(size: 16)], for: .highlighted)
        UIBarButtonItem.appearance().setTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -2.0), for: UIBarMetrics.default)
        
        return true
    }
}

