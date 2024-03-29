//
//  TickerController.swift
//  Portfolio
//
//  Created by Ausias on 03/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation



class TickerController : TickerProtocol {
    
    var delegate: TickerControllerDelegate?
    
    /** Object responsible for retrieving data from the ticker web service. It acts
     as an API wrapper for every particular ticker data provider. */
    var ticker: AnyObject
    
    /** Nested array containing the ticker data. Stores a JSON
     structure coming from a data transfer object (DTO). */
    var tickerData: [[String: Any]] {
        didSet {
            // Notify delegate that we got new data!
            delegate?.tickerControllerDidUpdateData(self)
        }
    }
    
    
    
    /** Initializes the ticker. */
    required init () {
        ticker = 0 as AnyObject
        tickerData = [[:]]
    }

    
    
    /** Retrieves data from the ticker. */
    func getTickerData() {
        print("generic ticker")
    }
    
    
    func getPriceForAsset(_ name: String) -> [String: Float] {
        return [:]
    }
    
    
    func getPercentChange(_ name: String) -> [String: Float] {
        return [:]
    }
    
    func getCurrencyPairForAsset(_ name: String) -> [CurrencySymbol] {
        return []
    }
}



protocol TickerControllerDelegate {
    func tickerControllerDidUpdateData(_ tickerController: TickerController)
}
