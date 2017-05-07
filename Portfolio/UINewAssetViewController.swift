//
//  UINewAssetViewController.swift
//  Portfolio
//
//  Created by Ausias on 07/05/17.
//  Copyright © 2017 kobiuter. All rights reserved.
//

import UIKit

class UINewAssetViewController: UIViewController, UIPickerViewDataSource,
UIPickerViewDelegate {

    var delegate: Any?
    
    @IBAction func DoneButton(_ sender: Any) {
        // Pass new asset to parent view controller
        let ass: Asset = Asset(name: "Augur", quantity: 34)
        (delegate as! UINewAssetViewControllerDelegate).newAssetViewController(self, didReturnNewAsset: ass)
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    // MARK: - Picker View Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    
    
    // MARK: - Picker View Delegate
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(component) * 20
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "title row " + String(row) + "comp " + String(component)
    }
    
    
    
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        <#code#>
//    }
    

}



//  o--o  o--o   o-o  o-O-o  o-o    o-o  o-o  o     o-o
//  |   | |   | o   o   |   o   o  /    o   o |    |
//  O--o  O-Oo  |   |   |   |   | O     |   | |     o-o
//  |     |  \  o   o   |   o   o  \    o   o |        |
//  o     o   o  o-o    o    o-o    o-o  o-o  O---oo--o
//
// MARK: - Delegate methods for the Portfolio Table View Controller
protocol UINewAssetViewControllerDelegate {
    func newAssetViewController(_ newAssetViewController: UINewAssetViewController, didReturnNewAsset anAsset:Asset)
}
