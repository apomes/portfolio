//
//  TickerFactory.swift
//  Portfolio
//
//  Created by Ausias on 03/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation



/**
 Factory pattern method that produces specific ticker controllers. This
 decouples our code from changes in the various ticker APIs.
*/
class TickerFactory {
    /**
     It makes concrete instances of tickers given a ticker type.
     
     - parameters:
     - tickerType: String that refers to the type of the ticker.
     
     - returns:
     An object which si a subclass of TickerController to manage a specific ticker.
     */
    static func makeTickerController(tickerType: TickerType) -> TickerFactory {
        switch tickerType {
        case TickerType.Poloniex:
            return PoloniexController()
        default:
            return PoloniexController()
        }
    }
}



/**
 Types of tickers currently supported.
 */
enum TickerType: String {
    case Poloniex = "Poloniex"
    case Kraken = "Kraken"
}