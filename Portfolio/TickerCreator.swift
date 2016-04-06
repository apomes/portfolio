//
//  TickerCreator.swift
//  Portfolio
//
//  Created by Ausias on 06/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation



class TickerCreator {
    
    
    
    
    class func makeTickerController(tickerType: TickerType) -> TickerController {
        switch tickerType {
        case TickerType.Poloniex:
            return PoloniexTickerController()
        case TickerType.Kraken:
            return KrakenTickerController()
        default:
            print("General ticker returned")
            return TickerController()
        }
    }
}



/** Types of tickers currently supported. */
enum TickerType: String {
    case Poloniex = "Poloniex"
    case Kraken = "Kraken"
    case Other = "Other"
}