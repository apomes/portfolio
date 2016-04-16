//
//  PortfolioModel.swift
//  Portfolio
//
//  Created by Ausias on 31/03/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation


/** Portfolio table model. */
class Portfolio : NSObject {
    
    var delegate: PortfolioTableViewController?
    
    /** List of tickers that provide data for our portfolio. */
    let myTickerList: TickerListController = TickerListController()
    
    /** List of assets. */
    var assetList = [Asset]()
    
    
    override init () {
        super.init()
        
        // Empty portfolio
        assetList = []
        
        /************ Ticker MODEL ****************/
        // Instantiate tickers
        // FIXME: tickers should only be instantiated if needed for the current portfolio of the user
        myTickerList.addTicker(TickerType.Poloniex)
        myTickerList.addTicker(TickerType.Kraken)
        
        // Add self as observer to track changes in the tickers
        myTickerList.attachObserver(self)
    }
    
    
    // MARK: - Methods to refresh data in the portfolio
    
    /** Triggers data update for all tickers. */
    func refresh() {
        myTickerList.update()
    }

    
    
    /** Pulls latest data from the tickers and tells controller to reload table. */
    func update() {
        // Updates assets with fresh data from the tickers
        updateAssets()
        
        // Tell portfolio controller to reload table with fresh data
        delegate?.portfolioDidUpdateData(self)
        
    }
    
    // MARK: - Setter methods to modify information in the portfolio
    
    /**
     Adds new asset to the portfolio. 
     
     - parameters:
        - name: full name of the asset.
        - value: quantity of the asset.
     */
    func addAsset(name: String, quantity:Float) {
        let anAsset = Asset(name: name, quantity: quantity)
        assetList.append(anAsset)
    }
    
    func removeAsset(name: String) {
        print("remove asset needs implementation...")
    }
    
    /** Updates data for all assets in the portfolio. */
    func updateAssets() {
        for asset in assetList {
            // Update price
            let pricePerTicker = myTickerList.getPricesForAsset(asset.name)
            // TODO: for now we just get the first pair, Poloniex. But we could
            // choose other exchanges and compute averages and so =D
            asset.price = pricePerTicker.first!.1
            
            // Update change
            let percentChange = myTickerList.getPercentChangesForAsset(asset.name)
            asset.percentChange = percentChange.first!.1
        }
    }

    
    // MARK: - Getter methods to retrieve information from the portfolio

    func numberOfAssets() -> Int {
        return assetList.count
    }
    
    
    func getNameForAsset(index: Int) -> String {
        return assetList[index].name
    }
    
    func getPriceForAsset(index: Int) -> Float {
        return assetList[index].price
    }
    
    func getPriceForAssetFormatted(index: Int) -> String {
        return NumberFormatter.sharedInstance.stringFromNumber(assetList[index].price)!
    }
    
    func getPercentChangeForAsset(index: Int) -> Float {
        return assetList[index].percentChange
    }
    
    func getTotalValue() -> Float {
        var total: Float = 0.0
        for item in assetList {
            total += item.quantity
        }
        return total
    }
    
    
    // MARK: - Sort methods to display portfolio in a certain order
    // TODO: For instance, sort by quantity of the asset, name, price, ...
    
}




protocol PortfolioDelegate {
    func portfolioDidUpdateData (portfolio: Portfolio)
}