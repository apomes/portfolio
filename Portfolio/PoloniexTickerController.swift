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
                print("__Got the ticker data")
                self.tickerData = data
            }
        }
    }

    
    
    
    override func getPriceForAsset(_ name: String) -> [String: Float] {
        // Init return price
        var lastPrice: Float = -1
        
        // Get currency pair for the asset
        let currencyPair = getPoloniexCurrencyPairForCurrency(name)
        //print("currencyPair is \(currencyPair)")
        
        // Get the price for the currency pair from tickerData
        if currencyPair != "" {
            lastPrice = getPriceForSymbol(currencyPair)!
        }
        return ["Poloniex": lastPrice]
    }


    // From GPT
    func getPriceForSymbol(_ symbol: String) -> Float? {
        if let symbolData = self.tickerData.first(where: { $0["symbol"] as? String == symbol }),
           let priceString = symbolData["price"] as? String,
           let price = Float(priceString) {
            return price
        }
        return -1
    }
    
    
    
    override func getPercentChange(_ name: String) -> [String: Float] {
        // Init return percent change
        var percentChange: Float = -1
        
        // Get currency pair for the asset
        let currencyPair = getPoloniexCurrencyPairForCurrency(name)
        
        // Get percent change for the currency pair from the tickerData
        if currencyPair != "" {
            percentChange = getPercentChangeForSymbol(currencyPair)!
        }
        return ["Poloniex" : percentChange]
    }

    
    
    func getPercentChangeForSymbol(_ symbol: String) -> Float? {
        if let symbolData = self.tickerData.first(where: { $0["symbol"] as? String == symbol }),
           let dailyChangeString = symbolData["dailyChange"] as? String,
           let dailyChange = Float(dailyChangeString) {
            let percentChange = dailyChange * 100;
            return percentChange
        }
        return -1
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
    /** BaseCurrency_CounterCurrency = BaseCurrency_QuoteCurrency */
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
                // Poloniex puts the base currency in first place
                let baseCurrency = currencyList.first!
                
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
            let counterCurrency = aCurrencyPair.components(separatedBy: "_").last!
            if counterCurrency.contains(aCounterCurrency.rawValue) {
                return aCurrencyPair
            }
        }
        return ""
    }
}
