//
//  PoloniexController.swift
//  Portfolio
//
//  Created by Ausias on 03/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation

class PoloniexTickerController: TickerController {
    
    let APIKey: String = "VJC0L8L2-UDFKQDZZ-CL9V2XGZ-07ZCJVS5"
    let Secret: String = "eb93db31bf5a5b531186154676a8e5b4939c13c13bd26666ef46717/b58d7e4e9bd12a5d11aba8db9d012f4417c3ff2a495504fc45dff61156f4ed3eb130a93db"
    
    
    required init () {
        print("Creating poloniex ticker...")
        
        super.init()
        
        // Init poloniex ticker
        self.ticker = PoloniexTicker(withAPIKey: APIKey, withSecret: Secret)
    }
    
    
    
    internal override func getTickerData() {
        // Get ticker
        (self.ticker as! PoloniexTicker).returnTicker() {
            (data, error) -> Void in
            if error != nil {
                print(error)
            } else {
                self.tickerData = data
            }
        }
    }
}