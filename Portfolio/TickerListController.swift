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
class TickerListController: TickerControllerDelegate  {
    
    /** List of objects that control the tickers. */
    var tickerList: [TickerController]
    
    
    /** List of observers who need updating when ticker data changes. */
    var observers = [AnyObject]()
    
    
    init () {
        tickerList = []
    }
    
    
    
    /**
     Creates a new ticker of type tickerType and adds it to the list. 
     
     - parameters:
        - tickerType: Enum with the type of the ticker to instantiate
     */
    func addTicker(tickerType: TickerType) {
        let myTicker: TickerController = TickerCreator.makeTickerController(tickerType)
        myTicker.delegate = self
        tickerList.append(myTicker)
    }
    
    
    
    /** Refreshes all tickers data. */
    func update() {
        for aTickerController in tickerList {
            aTickerController.getTickerData()
        }
    }
    
    /** Returns data averaged across tickers. */
//    func average(asset: String) -> Float {
//        return 0.0
//    }
    
    
    
    func getPricesForAsset(name: String) -> [String: Float] {
        var prices = [String: Float]()
        
        // Get price in all available tickers
        for aTickerController in tickerList {
            let price = aTickerController.getPriceForAsset(name)
            
            // Check that we actually got a price from the ticker
            if price.count > 0 {
                prices[price.first!.0] = price.first!.1
            }
        }
        
        return prices
    }
    
    
    
    func getPercentChangesForAsset(name: String) -> [String: Float] {
        var percentChanges = [String: Float]()
        
        // Get price in all available tickers
        for aTickerController in tickerList {
            let percentChange = aTickerController.getPercentChange(name)
            
            // Check that we actually got a price from the ticker
            if percentChange.count > 0 {
                percentChanges[percentChange.first!.0] = percentChange.first!.1
            }
        }
        
        return percentChanges
    }
    
    
    
    func getCurrencyPairsForAsset(name: String) -> [[CurrencySymbol]] {
        var currencyPairs = [[CurrencySymbol]]()
        for aTickerController in tickerList {
            let currencyPair = aTickerController.getCurrencyPairForAsset(name)
            currencyPairs.append(currencyPair)
        }
        return currencyPairs
    }
    
    
    //   o-o  o--o   o-o  o--o o--o  o   o o--o o--o
    //  o   o |   | |     |    |   | |   | |    |   |
    //  |   | O--o   o-o  O-o  O-Oo  o   o O-o  O-Oo
    //  o   o |   |     | |    |  \   \ /  |    |  \
    //   o-o  o--o  o--o  o--o o   o   o   o--o o   o
    //
    //
    
    // MARK: - Methods to implement the observer pattern
    
    /** Adds an observer that wants to be notified of changes in the model. */
    func attachObserver(anObserver: AnyObject) {
        observers.append(anObserver)
    }
    
    /** Detach an observer to stop receiving notifications on changes. */
    func detachObserver(anObserver: AnyObject) {
        // FIXME: This is probably wrong. Observers are of type Portfolio now
        let index = observers.indexOf( {$0.name == (anObserver as! Asset).name} )
        observers.removeAtIndex(index!)
    }
    
    /** Notify observers that the model has changed. */
    func notifyObservers() {
        print("Notifying \(observers.count) observers...")
        for item in observers {
            item.performSelector(#selector(Portfolio.update))
        }
    }
    
    
    
    //  o-o   o--o o    o--o  o-o    O  o-O-o o--o
    //  |  \  |    |    |    o      / \   |   |
    //  |   O O-o  |    O-o  |  -o o---o  |   O-o
    //  |  /  |    |    |    o   | |   |  |   |
    //  o-o   o--o O---oo--o  o-o  o   o  o   o--o
    //
    //
    
    // MARK: - Ticker controller delegate methods
    
    func tickerControllerDidUpdateData(tickerController: TickerController) {
        // Notify observers that there is new data
        notifyObservers()
    }
    
}

