//
//  PoloniexController.swift
//  Portfolio
//
//  Created by Ausias on 03/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation

class PoloniexTickerController: TickerController {
    
    // Gets ticker key and secret 
    let APIKey: String = apiKeyForTicker(tickerType: TickerType.Poloniex) as! String
    let Secret: String = apiSecretForTicker(tickerType: TickerType.Poloniex) as! String
    
    required init () {        
        super.init()
        
        // Init poloniex ticker (ticker model)
        self.ticker = PoloniexTicker(withAPIKey: APIKey, withSecret: Secret)
        
        // Get data for the first time
        getTickerData()
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
    
    
    
    override func getPriceForAsset(name: String) -> [String: Float] {
        // Init return price
        var lastPrice: Float = -1
        
        // Get currency pair for the asset
        let currencyPair = getPoloniexCurrencyPairForCurrency(name)
        
        // Check that the currency pair exists in the ticker data
        // to make sure it hasn't been delisted or something
        if (currencyPair != "") {
            // Get the specific ticker for the asset
            let assetTicker = self.tickerData[currencyPair]!
            
            // Get price
            lastPrice = Float((assetTicker["last"]!)! as! String)!
        }
        
        return ["Poloniex" : lastPrice]
    }
    
    
    
    override func getPercentChange(name: String) -> [String: Float] {
        // Init return percent change
        var percentChange: Float = -1
        
        // Get currency pair for the asset
        let currencyPair = getPoloniexCurrencyPairForCurrency(name)
        
        // Check that the currency pair exists in the ticker data
        // to make sure it hasn't been delisted or something
        if (currencyPair != "") {
            // Get the specific ticker for the asset
            let assetTicker = self.tickerData[currencyPair]!
            
            // Get percent change in value for the asset
            percentChange = Float(assetTicker["percentChange"] as! String)! * 100
        }
        
        return ["Poloniex" : percentChange]
    }
    
    
    
    /** Returns a list representing a currency pair. */
    override func getCurrencyPairForAsset(name: String) -> [CurrencySymbol] {
        var currencyPair = [CurrencySymbol]()
        
        let poloniexCurrencyPair = getPoloniexCurrencyPairForCurrency(name)
        let currencies = poloniexCurrencyPair.componentsSeparatedByString("_")
        
        currencyPair.append(CurrencySymbolConverter.sharedInstance.getSymbolForName(currencies.first!))
        currencyPair.append(CurrencySymbolConverter.sharedInstance.getSymbolForName(currencies.last!))
        
        return currencyPair
    }
    
    
    
    /** Returns a currency pair in Poloniex format with most popular counter currency. First USD, then BTC, then others. */
    private func getPoloniexCurrencyPairForCurrency(name: String) -> String {
        
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
    private func getCurrencyPairsForCurrency(name: String) -> [String] {
        var currencyPairs = [String]()
        
        // Get base currency symbol from currency name
        let baseCurrencySymbol = CurrencySymbolConverter.sharedInstance.getSymbolForName(name)
        
        // Search currency pairs that contain the base currency in ticker data
        for item in self.tickerData {
            let currencyPair = item.0
            
            // Get currencies in pair
            let currencyList = currencyPair.componentsSeparatedByString("_")
            // Poloniex puts the base currency in last place
            let baseCurrency = currencyList.last!
            
            // Check if base currency symbol is contained in currency pair
            if baseCurrency.containsString(baseCurrencySymbol.rawValue) {
                currencyPairs.append(currencyPair)
            }
        }
        
        return currencyPairs
    }
    
    
    
    private func getCurrencyPairForCounterCurrency(aCounterCurrency: CurrencySymbol, currencyPairs: [String]) -> String {
        for aCurrencyPair in currencyPairs {
            let counterCurrency = aCurrencyPair.componentsSeparatedByString("_").first!
            if counterCurrency.containsString(aCounterCurrency.rawValue) {
                return aCurrencyPair
            }
        }
        return ""
    }
}