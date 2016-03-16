//
//  AppDelegate.swift
//  FordhamMuseum
//
//  Created by Michael Gonzales on 3/1/16.
//  Copyright © 2016 FordhamMuseumApp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let GreekNavigationController = storyboard.instantiateViewControllerWithIdentifier("CollectionNavigationController") as! UINavigationController
        let GreekViewController = GreekNavigationController.topViewController as! CollectionViewController
        // GreekViewController.endpoint = "now_playing"
        GreekNavigationController.tabBarItem.title = "Greek"
        GreekNavigationController.tabBarItem.image = UIImage(named: "Library-100")
        
        let EtruscanNavigationController = storyboard.instantiateViewControllerWithIdentifier("CollectionNavigationController") as! UINavigationController
        let EtruscanViewController = EtruscanNavigationController.topViewController as! CollectionViewController
        // GreekViewController.endpoint = "now_playing"
        EtruscanNavigationController.tabBarItem.title = "Etruscan"
        EtruscanNavigationController.tabBarItem.image = UIImage(named: "Archeology-100")
        
        let RomanNavigationController = storyboard.instantiateViewControllerWithIdentifier("CollectionNavigationController") as! UINavigationController
        let RomanViewController = RomanNavigationController.topViewController as! CollectionViewController
        // GreekViewController.endpoint = "now_playing"
        RomanNavigationController.tabBarItem.title = "Roman"
        RomanNavigationController.tabBarItem.image = UIImage(named: "Colosseum-100")
        
        let MosaicsNavigationController = storyboard.instantiateViewControllerWithIdentifier("CollectionNavigationController") as! UINavigationController
        let MosaicsViewController = MosaicsNavigationController.topViewController as! CollectionViewController
        // GreekViewController.endpoint = "now_playing"
        MosaicsNavigationController.tabBarItem.title = "Mosaics"
        MosaicsNavigationController.tabBarItem.image = UIImage(named: "Library-100")
        
        let MiscNavigationController = storyboard.instantiateViewControllerWithIdentifier("CollectionNavigationController") as! UINavigationController
        let MiscViewController = MiscNavigationController.topViewController as! CollectionViewController
        // GreekViewController.endpoint = "now_playing"
        MiscNavigationController.tabBarItem.title = "Misc"
        MiscNavigationController.tabBarItem.image = UIImage(named: "Library-100")
        
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [GreekNavigationController, EtruscanNavigationController, RomanNavigationController, MosaicsNavigationController, MiscNavigationController]

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()


        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

