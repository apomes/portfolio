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