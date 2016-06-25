//
//  TickerCreator.swift
//  Portfolio
//
//  Created by Ausias on 06/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation



class TickerCreator {
    
    /**
     Checks the argument and returns an instance of the appropriate ticker
     Controller.
     
     - parameters:
        - tickerType: Type of ticker to be instantiated. It's an ENUM.
     - returns: A concrete instance of TickerController.
     */
    class func makeTickerController(tickerType: TickerType) -> TickerController {
        switch tickerType {
        case TickerType.Poloniex:
            return PoloniexTickerController()
        case TickerType.Kraken:
            return KrakenTickerController()
        case TickerType.Bittrex:
            return BittrexTickerController()
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
    case Bittrex = "Bittrex"
    case Other = "Other"
}