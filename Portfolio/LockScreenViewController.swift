//
//  LockScreenViewController.swift
//  Portfolio
//
//  Created by Ausias on 23/06/17.
//  Copyright © 2017 kobiuter. All rights reserved.
//

import UIKit
import LocalAuthentication



class LockScreenViewController: UIViewController {

    
    var isLocked = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    /**
     Protect UI with local authentication for privacy.
     */
    func requestLocalAuthentication() {
        let myContext = LAContext()
        let myLocalizedReasonString = "Unlock Portfolio."
        
        var authError: NSError? = nil
        if #available(iOS 8.0, OSX 10.12, *) {
            if myContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { (success, evaluateError) in
                    if (success) {
                        // User authenticated successfully, dismiss lock screen controller
                        self.dismiss(animated: true, completion: nil)
                        self.isLocked = false
                        
                    } else {
                        // User did not authenticate successfully, look at error and take appropriate action
                        
                    }
                }
            } else {
                // Could not evaluate policy; look at authError and present an appropriate message to user
                let alertController = UIAlertController(title: "Error", message: authError?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
            }
        } else {
            // Fallback on earlier versions
            
            
        }
    }

}
