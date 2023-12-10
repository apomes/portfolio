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
    let APIKey: String = apiKeyForTicker(tickerType: TickerType.Poloniex) 
    let Secret: String = apiSecretForTicker(tickerType: TickerType.Poloniex) 
    
    required init () {        
        super.init()
        
        // Init poloniex ticker (ticker model)
        self.ticker = PoloniexTicker(withAPIKey: APIKey, withSecret: Secret)
        
        // Get data for the first time
        getTickerData()
    }
    
    
//
//    internal override func getTickerData() {
//        // Get ticker
//        (self.ticker as! PoloniexTicker).returnTicker() {
//            (data, error) -> Void in
//            if error != nil {
//                print(error!)
//            } else {
//                self.tickerData = data
//            }
//        }
//    }
    
    internal override func getTickerData() {
        // Get ticker
        (self.ticker as! PoloniexTicker).returnTicker() { (data, error) -> Void in
            if let error = error {
                print(error)
            } else {
                // Assuming self.tickerData is of type [String: Any]
                self.tickerData = data
            }
        }
    }

    
    
    
    override func getPriceForAsset(_ name: String) -> [String: Float] {
        // Init return price
        var lastPrice: Float = -1
        
        // Get currency pair for the asset
        let currencyPair = getPoloniexCurrencyPairForCurrency(name)
        
        // Check that the currency pair exists in the ticker data
        // to make sure it hasn't been delisted or something
        if let assetTicker = self.tickerData[[currencyPair]] as? [String: Any] {
            // Get price
            if let lastPriceString = assetTicker["last"] as? String,
               let lastPriceFloat = Float(lastPriceString) {
                lastPrice = lastPriceFloat
            }
        }
        
        return ["Poloniex": lastPrice]
    }

    
    
    
    override func getPercentChange(_ name: String) -> [String: Float] {
        // Init return percent change
        var percentChange: Float = -1
        
        // Get currency pair for the asset
        let currencyPair = getPoloniexCurrencyPairForCurrency(name)
        
        // Check that the currency pair exists in the ticker data
        // to make sure it hasn't been delisted or something
//        if let assetTicker = self.tickerData[[currencyPair]] as? [String: Any] {
//            // Get percent change in value for the asset
//            if let percentChangeString = assetTicker["percentChange"] as? String,
//               let percentChangeFloat = Float(percentChangeString) {
//                percentChange = percentChangeFloat * 100
//            }
//        }
        
        return ["Poloniex" : percentChange]
    }

    
    
    
    /** Returns a list representing a currency pair. */
    override func getCurrencyPairForAsset(_ name: String) -> [CurrencySymbol] {
        var currencyPair = [CurrencySymbol]()
        
        let poloniexCurrencyPair = getPoloniexCurrencyPairForCurrency(name)
        let currencies = poloniexCurrencyPair.components(separatedBy: "_")
        
        currencyPair.append(CurrencySymbolConverter.sharedInstance.getSymbolForName(currencies.first!))
        currencyPair.append(CurrencySymbolConverter.sharedInstance.getSymbolForName(currencies.last!))
        
        return currencyPair
    }
    
    
    
    /** Returns a currency pair in Poloniex format with most popular counter currency. First USD, then BTC, then others. */
    fileprivate func getPoloniexCurrencyPairForCurrency(_ name: String) -> String {
        
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
        if self.tickerData.first!.count != 0 {
            for item in self.tickerData {
                // Get the currency pair. E.g. BTC_USDT
                let currencyPair: String = item["symbol"] as! String
                // Get currencies in pair
                let currencyList = currencyPair.components(separatedBy: "_")
                // Poloniex puts the base currency in last place
                let baseCurrency = currencyList.last!
                print("baseCurrency is ", baseCurrency)
                
                // Check if base currency symbol is contained in currency pair
                if baseCurrency == baseCurrencySymbol.rawValue {
                    currencyPairs.append(currencyPair)
                }
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
