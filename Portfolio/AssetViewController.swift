//
//  AssetViewController.swift
//  Portfolio
//
//  Created by Ausias on 07/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import UIKit

class AssetViewController: UIViewController {

    
    @IBAction func UIAssetViewDoneButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
