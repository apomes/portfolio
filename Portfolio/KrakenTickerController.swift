//
//  KrakenTickerController.swift
//  Portfolio
//
//  Created by Ausias on 06/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation


class KrakenTickerController: TickerController {
    
    let APIKey: String = apiKeyForTicker(tickerType: TickerType.Kraken) as! String
    let Secret: String = apiSecretForTicker(tickerType: TickerType.Kraken) as! String
    
    
    required init () {        
        super.init()
        
        // Init kraken ticker (ticker model)
        self.ticker = KrakenTicker(withAPIKey: APIKey, withSecret: Secret)
    }
    
    
    
    internal override func getTickerData() {
        print("GetTickerData for Kraken needs implementation...")
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