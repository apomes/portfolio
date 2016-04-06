//
//  TickerController.swift
//  Portfolio
//
//  Created by Ausias on 03/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation



class TickerController : TickerProtocol {
    
    /** Object responsible for retrieving data from the ticker web service. It acts
     as an API wrapper for every particular ticker data provider. */
    var ticker: AnyObject
    
    /** Nested array containing the ticker data. This corresponds to a JSON 
     structure coming from a data transfer object (DTO). */
    var tickerData: [String: AnyObject]
    
    
    
    /** Initializes the ticker. */
    required init () {
        ticker = 0
        tickerData = [:]
    }
    
    /** Retrieves data from the ticker. */
    func getTickerData() {}
}