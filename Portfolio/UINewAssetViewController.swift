//
//  UINewAssetViewController.swift
//  Portfolio
//
//  Created by Ausias on 07/05/17.
//  Copyright © 2017 kobiuter. All rights reserved.
//

import UIKit

class UINewAssetViewController: UIViewController, UIPickerViewDataSource,
UIPickerViewDelegate, UITextFieldDelegate {

    var delegate: Any?
    
    // Asset information
    var assetName: String = ""
    var assetQuantity: Float = 0
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var assetQuantityField: UITextField!
    
    @IBAction func assetQuantityField(_ sender: Any) {
//        assetQuantity = NumberFormatter.sharedInstance.number(from: assetQuantityField.text!) as Float? ?? 0
    }
    
    
    @IBAction func DoneButton(_ sender: Any) {
        // Get asset data
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        assetName = pickerView(pickerView, titleForRow: selectedRow, forComponent: 0)!
        assetQuantity = NumberFormatter.sharedInstance.number(from: assetQuantityField.text!) as Float? ?? 0
        
        if assetName != "" {
            // Pass new asset to parent view controller
            (delegate as! UINewAssetViewControllerDelegate)
                .newAssetViewController(self,
                                        didReturnNewAssetWithName: assetName,
                                        quantity: assetQuantity)
        }

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
        return 5
    }
    
    
    
    // MARK: - Picker View Delegate
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(component) * 40
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return ""
        case 1:
            return "Augur"
        case 2:
            return "Ethereum Classic"
        case 3:
            return "Monero"
        case 4:
            return "Ripple"
        default:
            return "Error"
        }
    }
    
    
    
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        <#code#>
//    }
    
    
    
    // MARK: - Text field delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.returnKeyType = UIReturnKeyType.done
        assetQuantityField.text = ""
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if assetQuantityField.text == "" {
            assetQuantityField.text = "0"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        assetQuantityField.endEditing(false)
        return false
    }
}



//  o--o  o--o   o-o  o-O-o  o-o    o-o  o-o  o     o-o
//  |   | |   | o   o   |   o   o  /    o   o |    |
//  O--o  O-Oo  |   |   |   |   | O     |   | |     o-o
//  |     |  \  o   o   |   o   o  \    o   o |        |
//  o     o   o  o-o    o    o-o    o-o  o-o  O---oo--o
//
// MARK: - Delegate methods for the Portfolio Table View Controller
protocol UINewAssetViewControllerDelegate {
    func newAssetViewController(_ newAssetViewController: UINewAssetViewController, didReturnNewAssetWithName assetName:String, quantity: Float)
}
