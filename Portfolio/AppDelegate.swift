//
//  AppDelegate.swift
//  Portfolio
//
//  Created by Ausias on 12/03/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import UIKit
import LocalAuthentication

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var portfolioRootViewController: PortfolioViewController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // The root view controller is the main navigation view controller. 
        // Its first child is the portfolio view controller
        portfolioRootViewController = self.window?.rootViewController?.childViewControllers[0] as! PortfolioViewController
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
        // Protect UI with local authentication for privacy
        presentLockScreen()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        // Save portfolio data!
        portfolioRootViewController.savePortfolioData()
        
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    /**
     Protect UI with local authentication for privacy.
     */
    func presentLockScreen() {
        let myContext = LAContext()
        let myLocalizedReasonString = "Unlock Portfolio."
        
        var authError: NSError? = nil
        if #available(iOS 8.0, OSX 10.12, *) {
            if myContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { (success, evaluateError) in
                    if (success) {
                        // User authenticated successfully, take appropriate action
                        
                    } else {
                        // User did not authenticate successfully, look at error and take appropriate action
                        
                    }
                }
            } else {
                // Could not evaluate policy; look at authError and present an appropriate message to user
                let alertController = UIAlertController(title: "Error", message: authError?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                alertController.addAction(alertAction)
                self.portfolioRootViewController.present(alertController, animated: true, completion: nil)
            }
        } else {
            // Fallback on earlier versions
            
            
        }
    }


}

