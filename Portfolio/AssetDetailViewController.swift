//
//  AssetDetailViewController.swift
//  Portfolio
//
//  Created by Ausias on 06/05/17.
//  Copyright © 2017 kobiuter. All rights reserved.
//

import UIKit

class AssetDetailViewController: UIViewController {

    var asset:Asset?
    
    @IBOutlet weak var assetName: UILabel!
    
    @IBOutlet weak var assetQuantity: UITextField!
    @IBAction func assetQuantity(_ sender: Any) {
        asset?.quantity = NumberFormatter.sharedInstance.number(from: assetQuantity.text!) as Float? ?? 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        assetName.text = asset?.name
        assetQuantity.text = NumberFormatter.sharedInstance.string(from: NSNumber(value: (asset?.quantity)!))!
        
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

}
