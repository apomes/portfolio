//
//  BittrexTickerController.swift
//  Portfolio
//
//  Created by Ausias on 06/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation


class BittrexTickerController: TickerController {
    
    let APIKey: String = apiKeyForTicker(tickerType: TickerType.Bittrex) as! String
    let Secret: String = apiSecretForTicker(tickerType: TickerType.Bittrex) as! String
    
    
    required init () {        
        super.init()
        
        // Init Bittrex ticker (ticker model)
        self.ticker = BittrexTicker(withAPIKey: APIKey, withSecret: Secret)
    }
    
    
    
    internal override func getTickerData() {
        print("GetTickerData for Bittrex needs implementation...")
        // Get ticker
//        (self.ticker as! PoloniexTicker).returnTicker() {
//            (data, error) -> Void in
//            if error != nil {
//                print(error)
//            } else {
//                self.tickerData = data
//            }
//        }
    }
}