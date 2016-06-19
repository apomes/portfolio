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
func apiKeyForTicker(tickerType tickerType:TickerType) -> AnyObject {
    let filePath = NSBundle.mainBundle().pathForResource("ApiKeys", ofType:"plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let tickerSecret:AnyObject = (plist?.objectForKey(tickerType.rawValue))!
    
    return tickerSecret.valueForKey("API_KEY")!
}



/**  */
func apiSecretForTicker(tickerType tickerType:TickerType) -> AnyObject {
    let filePath = NSBundle.mainBundle().pathForResource("ApiKeys", ofType:"plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let tickerSecret:AnyObject = (plist?.objectForKey(tickerType.rawValue))!
    
    return tickerSecret.valueForKey("API_SECRET")!
}