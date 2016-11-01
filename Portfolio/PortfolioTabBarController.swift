//
//  PortfolioTabBarController.swift
//  Portfolio
//
//  Created by Ausias on 30/03/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import UIKit

class PortfolioTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        print("Status bar style")
        return .lightContent // can also return: .Default (black on light), .BlackOpaque (opaque black)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
