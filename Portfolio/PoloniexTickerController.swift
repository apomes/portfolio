//
//  PoloniexController.swift
//  Portfolio
//
//  Created by Ausias on 03/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation

class PoloniexTickerController: TickerController {
    
    // TODO: Generate new keys before open sourcing
    let APIKey: String = valueForAPIKey(keyname: "API_CLIENT_ID") as! String
    let Secret: String = valueForAPIKey(keyname: "API_SECRET") as! String
    
    
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
        // Get currency pair for the asset
        let currencyPair = getCurrencyPairForCurrency(name)
        
        // Get the specific ticker for the asset
        let assetTicker = self.tickerData[currencyPair]!
        
        // Get price
        let lastPrice = Float((assetTicker["last"]!)! as! String)!
        
        return ["Poloniex" : lastPrice]
    }
    
    
    
    override func getPercentChange(name: String) -> [String: Float] {
        // Get currency pair for the asset
        let currencyPair = getCurrencyPairForCurrency(name)
        
        // Get the specific ticker for the asset
        let assetTicker = self.tickerData[currencyPair]!
        
        // Get percent change in value for the asset
        let percentChange: Float = Float(assetTicker["percentChange"] as! String)! * 100
        
        return ["Poloniex" : percentChange]
    }
    
    
    
    /** Returns the Poloniex currency pair for a specific currency */
    // TODO: modify this method to incorporate currencies with multiple currency pairs (Eg. BTC_LTC and USD_LTC for Litecoin)
    private func getCurrencyPairForCurrency(name: String) -> String {
        var currencyPair: String
        switch name {
        case "Factom":
            currencyPair = "BTC_FCT"
        case "Counterparty":
            currencyPair = "BTC_XCP"
        case "Ethereum":
            currencyPair = "USDT_ETH"
        case "Dash":
            currencyPair = "BTC_DASH"
        case "Dogecoin":
            currencyPair = "BTC_DOGE"
        case "Bitcoin":
            currencyPair = "USDT_BTC"
        case "Litecoin":
            currencyPair = "USDT_LTC"
        default:
            currencyPair = ""
        }
        return currencyPair
    }
}