//
//  KrakenTicker.swift
//  Portfolio
//
//  Created by Ausias on 10/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation

class KrakenTicker {
    
    // TODO: The key, secret and the init method could probably go into a base Ticker class.
    var APIKey: String
    var Secret: String
    
    
    
    /**
     Inits the Kraken class with authentication parameters.
     
     This initializer gets and API key and the Secret and stores them in the
     corresponding member variables.
     
     - parameter aPIKey: The API key to authentiate with Poloniex.
     - parameter Secret: The Secret to authenticate with Poloniex.
     */
    init(withAPIKey aPIKey: String, withSecret secret: String) {
        self.APIKey = aPIKey
        self.Secret = secret
    }
    
    
    
    
}