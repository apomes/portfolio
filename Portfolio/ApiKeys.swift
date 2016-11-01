//
//  ApiKeys.swift
//  Portfolio
//
//  Created by Ausias on 16/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//
//  Purpose: It offers methods to read API keys and Secrets from a plist file.

import Foundation



/** Extracts the API keys values from a plist file.  */
func apiKeyForTicker(tickerType:TickerType) -> String {
    let filePath = Bundle.main.path(forResource: "ApiKeys", ofType:"plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let tickerSecret: NSDictionary = (plist?.object(forKey: tickerType.rawValue))! as! NSDictionary
    
    return tickerSecret.value(forKey: "API_KEY") as! String
}



/**  */
func apiSecretForTicker(tickerType:TickerType) -> String {
    let filePath = Bundle.main.path(forResource: "ApiKeys", ofType:"plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let tickerSecret: NSDictionary = (plist?.object(forKey: tickerType.rawValue))! as! NSDictionary
    
    return tickerSecret.value(forKey: "API_SECRET") as! String
}
