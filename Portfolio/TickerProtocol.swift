//
//  TickerProtocol.swift
//  Portfolio
//
//  Created by Ausias on 06/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation



/** Every ticker must comply with this protocol.
 It needs a way to be initialized and a way to retrieve data. */
protocol TickerProtocol {
    /** Object responsible for retrieving data from the ticker web service. It acts
     as an API wrapper for every particular ticker data provider. */
    var ticker: AnyObject {get set}
    
    /** Nested array containing the ticker data. This corresponds to a JSON
     structure coming from a data transfer object (DTO). */
    var tickerData: [String: AnyObject] {get set}
    
    
    
    /** Initializes the ticker. */
    init ()
    
    /** Retrieves data from the ticker. */
    func getTickerData()
}