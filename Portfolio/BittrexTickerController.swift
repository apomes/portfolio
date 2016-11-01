//
//  BittrexTickerController.swift
//  Portfolio
//
//  Created by Ausias on 06/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation


class BittrexTickerController: TickerController {
    
    let APIKey: String = apiKeyForTicker(tickerType: TickerType.Bittrex) 
    let Secret: String = apiSecretForTicker(tickerType: TickerType.Bittrex) 
    
    
    required init () {        
        super.init()
        
        // Init Bittrex ticker (ticker model)
        self.ticker = BittrexTicker(withAPIKey: APIKey, withSecret: Secret)
        
        // Get data for the first time
        getTickerData()
    }
    
    
    
    internal override func getTickerData() {
        // Get ticker
        (self.ticker as! BittrexTicker).returnTicker() {
            (data, error) -> Void in
            if error != nil {
                print(error)
            } else {
                self.tickerData = data
            }
        }
    }
    
    
    
    override func getPriceForAsset(_ name: String) -> [String: Float] {
        // Init return price
        var lastPrice: Float = -1
        
        // Get currency pair for the asset
        let currencyPair = getBittrexCurrencyPairForCurrency(name)
        
        // Check that the currency pair exists in the ticker data
        // to make sure it hasn't been delisted or something
        if (currencyPair != "") {
            // Get the specific ticker for the asset
            let assetTicker = self.tickerData[currencyPair]!
            
            // Get price
            lastPrice = Float((assetTicker["last"]!)! as! String)!
        }
        
        return ["Bittrex" : lastPrice]
    }
    
    
    
    /** Returns a currency pair in Bittrex format with most popular counter currency. First USD, then BTC, then others. */
    fileprivate func getBittrexCurrencyPairForCurrency(_ name: String) -> String {
        
        let currencyPairs = getCurrencyPairsForCurrency(name)
        
        // Try to get currencyPair with USD as counter currency
        var currencyPair = getCurrencyPairForCounterCurrency(CurrencySymbol.Dollar, currencyPairs: currencyPairs)
        if currencyPair.isEmpty {
            // Try to get currencyPair with BTC as counter currency
            currencyPair = getCurrencyPairForCounterCurrency(CurrencySymbol.Bitcoin, currencyPairs: currencyPairs)
        }
        // TODO: add other counter currencies here, like Monero...
        // ...
        
        return currencyPair
    }
    
    
    
    /** Returns the a list of currency pairs for a specific base currency */
    fileprivate func getCurrencyPairsForCurrency(_ name: String) -> [String] {
        var currencyPairs = [String]()
        
        // Get base currency symbol from currency name
        let baseCurrencySymbol = CurrencySymbolConverter.sharedInstance.getSymbolForName(name)
        
        // Search currency pairs that contain the base currency in ticker data
        for item in self.tickerData {
            let currencyPair = item.0
            
            // Get currencies in pair
            let currencyList = currencyPair.components(separatedBy: "-")
            // Bittrex puts the base currency in last place
            let baseCurrency = currencyList.last!
            
            // Check if base currency symbol is contained in currency pair
            if baseCurrency.contains(baseCurrencySymbol.rawValue) {
                currencyPairs.append(currencyPair)
            }
        }
        
        return currencyPairs
    }
    
    
    
    fileprivate func getCurrencyPairForCounterCurrency(_ aCounterCurrency: CurrencySymbol, currencyPairs: [String]) -> String {
        for aCurrencyPair in currencyPairs {
            let counterCurrency = aCurrencyPair.components(separatedBy: "_").first!
            if counterCurrency.contains(aCounterCurrency.rawValue) {
                return aCurrencyPair
            }
        }
        return ""
    }
    
}
