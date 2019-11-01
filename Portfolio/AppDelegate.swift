//
//  AppDelegate.swift
//  Portfolio
//
//  Created by Ausias on 12/03/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var portfolioRootViewController: PortfolioViewController!
    var lockScreenViewController: LockScreenViewController!
    var backgroundTaskID: UIBackgroundTaskIdentifier!
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // The root view controller is the main navigation view controller. 
        // Its first child is the portfolio view controller
        portfolioRootViewController = self.window?.rootViewController?.children[0] as? PortfolioViewController
        
        let myStoryboard:UIStoryboard = portfolioRootViewController.storyboard!
        lockScreenViewController = (myStoryboard.instantiateViewController(withIdentifier: "LockScreenID") as! LockScreenViewController)
        //lockScreenViewController.modalPresentationStyle = .overFullScreen

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        DispatchQueue.main.async() {
           // Request the task assertion and save the ID.
           self.backgroundTaskID = UIApplication.shared.beginBackgroundTask (withName: "Finish Network Tasks") {
              // End the task if time expires.
              UIApplication.shared.endBackgroundTask(self.backgroundTaskID!)
            self.backgroundTaskID = UIBackgroundTaskIdentifier.invalid
           }
                 
           // Hide info for privacy by presenting another view controller on top
           self.lockScreen()

           // Save portfolio data!
           self.portfolioRootViewController.savePortfolioData()
                 
           // End the task assertion.
           UIApplication.shared.endBackgroundTask(self.backgroundTaskID!)
            self.backgroundTaskID = UIBackgroundTaskIdentifier.invalid
        }

        
        
    }
    
    

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
        // Request local authentication for user privacy
        lockScreenViewController.requestLocalAuthentication()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    func lockScreen() {
        if (!lockScreenViewController.isLocked) {
            let currentTopVC: UIViewController? = self.getTopViewController()
            
            currentTopVC?.present(lockScreenViewController, animated: true, completion: nil)
            lockScreenViewController.isLocked = true
        }
    }
    
    
    
    func getTopViewController() -> UIViewController {
        var topViewController = UIApplication.shared.delegate!.window!!.rootViewController!
        while (topViewController.presentedViewController != nil) {
            topViewController = topViewController.presentedViewController!
        }
        return topViewController
    }

}

