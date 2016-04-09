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
    var tickerData: [String: AnyObject] {
        didSet {
            notifyObservers()
        }
    }
    
    /** List of observers who needs updating when ticker data changes. */
    var observers: [AnyObject]
    
    
    
    /** Initializes the ticker. */
    required init () {
        ticker = 0
        tickerData = [:]
        observers = []
    }
    
    /** Retrieves data from the ticker. */
    func getTickerData() {}
    
    /** Adds an observer that wants to be notified of changes in the model. */
    func attachObserver(anObserver: AnyObject) {
        observers.append(anObserver)
    }
    
    /** Notify observers that the model has changed. */
    func notifyObservers() {
        print("Notifying \(observers.count) observers...")
        for item in observers {
            item.performSelector("update:")
        }
    }
}