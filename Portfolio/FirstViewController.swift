//
//  FirstViewController.swift
//  Portfolio
//
//  Created by Ausias on 12/03/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController, UIScrollViewDelegate {

    let APIKey: String = "VJC0L8L2-UDFKQDZZ-CL9V2XGZ-07ZCJVS5"
    let Secret: String = "eb93db31bf5a5b531186154676a8e5b4939c13c13bd26666ef46717/b58d7e4e9bd12a5d11aba8db9d012f4417c3ff2a495504fc45dff61156f4ed3eb130a93db"
    
    // Init the poloniex wrapper
    var poloniexWrapper: Poloniex!
    
    var poloniexTicker: [String: AnyObject] = [:] {
        didSet {
            print("Poloniex ticker updated!")
            
            // Update ticker model
            updateTickerModel()
        }
    }
    
    
    @IBOutlet weak var LastValue: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Init poloniex wrapper
        poloniexWrapper = Poloniex(withAPIKey: APIKey, withSecret: Secret)
        
        getTickerData()
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    private func getTickerData() {
        // Get ticker
        poloniexWrapper.returnTicker() {
            (data, error) -> Void in
            if error != nil {
                print(error)
            } else {
                self.poloniexTicker = data
            }
        }
    }
    
    
    
    func updateTickerModel() {
        let factom = poloniexTicker["BTC_FCT"]!
        print("Last value is \((factom["last"]!)!)")
        
        
        dispatch_async(dispatch_get_main_queue(), {
            self.LastValue.text = "\((factom["last"]!)!)"
        })
        
        //print(poloniexTicker)
    }
    
    
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        getTickerData()
    }

}

