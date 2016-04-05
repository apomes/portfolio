//
//  TickerListController.swift
//  Portfolio
//
//  Created by Ausias on 03/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation



/**
 It manages a list of tickers. It can provide individual or aggregated data from
 the list of available tickers.
*/
class TickerListController  {
    var tickerList: [TickerFactory]
    
    init () {
        tickerList = []
        
    }
    
    func addTicker(tickerType: TickerType) {
        let myTicker: TickerFactory = TickerFactory.makeTickerController(tickerType)
        tickerList.append(myTicker)
    }
    
}

