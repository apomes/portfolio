//
//  PortfolioModel.swift
//  Portfolio
//
//  Created by Ausias on 31/03/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation


/** Portfolio table model. */
class Portfolio : NSObject, AssetDelegate {
    
    var delegate: PortfolioTableViewController?
    
    /** List of tickers that provide data for our portfolio. */
    let myTickerListController: TickerListController = TickerListController()
    
    /** List of assets. */
    var assetList = [Asset]()
    
    /** Persistence objects. */
    var _portfolioDataController: PortfolioDataController = PortfolioDataController()
    
    /** Sort method currently selected. */
    var sortMethod: SortMethod = SortMethod.Name
    let _maxSortMethods = SortMethod.count
    
    
    
    override init () {
        super.init()
        
        // Empty portfolio
        assetList = []
        
        /************ Ticker MODEL ****************/
        // Instantiate tickers
        // FIXME: tickers should only be instantiated if needed for the current portfolio of the user
        myTickerListController.addTicker(TickerType.Poloniex)
        //myTickerListController.addTicker(TickerType.Kraken)
//        myTickerListController.addTicker(TickerType.Bittrex)
        
        // Add self as observer to track changes in the tickers
        myTickerListController.attachObserver(self)
    }

    
    
    /** Initializes the portfolio with persistent data. */
    func initPortfolio() {
        for anAsset in _portfolioDataController.portfolioData! {
            let assetName = anAsset.key
            let assetQuantity = (anAsset.value as AnyObject).value(forKey: "quantity") as! NSNumber
            addAsset(assetName as! String, quantity: assetQuantity.floatValue)
        }
    }
    
    
    
    // MARK: - Methods to refresh data in the portfolio
    
    /** Triggers data update for all tickers. */
    func refresh() {
        myTickerListController.update()
    }

    
    
    /** Pulls latest data from the tickers and tells controller to reload table. */
    @objc func update() {
        // Updates assets with fresh data from the tickers
        updateAssets()
        
        // Make sure data stays sorted
        sortByMethod(aSortMethod: sortMethod)
        
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
    func addAsset(_ name: String, quantity:Float) {
        let anAsset = Asset(name: name, quantity: quantity)
        anAsset.delegate = self
        assetList.append(anAsset)
        
        // Trigger portfolio data update and table of assets
        update()
    }
    
    func removeAsset(_ name: String) {
        print("remove asset by name needs implementation...")
        
    }
    
    func removeAsset(index: Int) {
        assetList.remove(at: index)
    }
    
    /** Updates data for all assets in the portfolio. */
    private func updateAssets() {
        for asset in assetList {
            // Get prices
            let pricePerTicker = myTickerListController.getPricesForAsset(asset.name)
            
            // TODO: for now we just get the first pair, Poloniex. But we could
            // choose other exchanges and compute averages and so =D
            asset.price = pricePerTicker.first!.1
            
            // Get percent change in value
            let percentChange = myTickerListController.getPercentChangesForAsset(asset.name)
            asset.percentChange = percentChange.first!.1
            
            // Get currency pair
            let currencyPairs = myTickerListController.getCurrencyPairsForAsset(asset.name)
            
            // TODO: Remove hardcoded base currency!
            if (asset.name == "USD") {
                asset.counterCurrency = CurrencySymbol.Dollar
                asset.baseCurrency = CurrencySymbol.Dollar
            }
            else if (asset.name == "EUR") {
                asset.counterCurrency = CurrencySymbol.Dollar
                asset.baseCurrency = CurrencySymbol.Dollar
            }
            else if (asset.name == "GBP") {
                asset.counterCurrency = CurrencySymbol.Dollar
                asset.baseCurrency = CurrencySymbol.Dollar
            }
            else {
                asset.counterCurrency = currencyPairs.first?.last
                asset.baseCurrency = currencyPairs.first?.first
            }
            
        }
    }

    
    
    //   o-o  o--o o-O-o o-O-o o--o o--o   o-o
    //  o     |      |     |   |    |   | |
    //  |  -o O-o    |     |   O-o  O-Oo   o-o
    //  o   | |      |     |   |    |  \      |
    //   o-o  o--o   o     o   o--o o   o o--o
    //
    //
    // MARK: - Getter methods to retrieve information from the portfolio

    func numberOfAssets() -> Int {
        return assetList.count
    }
    
    func getAssetAtIndex(_ index: Int) -> Asset {
        return assetList[index]
    }
    
    func getNameForAsset(_ index: Int) -> String {
        return assetList[index].name
    }
    
    func getPriceForAsset(_ index: Int) -> Float {
        return assetList[index].price
    }
    
    func getPriceForAssetFormatted(_ index: Int) -> String {
        return NumberFormatter.sharedInstance.string(from: NSNumber(value: assetList[index].price))!
    }
    
    func getPercentChangeForAsset(_ index: Int) -> Float {
        return assetList[index].percentChange
    }
    
    func getQuantityForAsset(_ index: Int) -> Float {
        return assetList[index].quantity
    }
    
    func getQuantityForAssetFormatted(_ index: Int) -> String {
        return NumberFormatter.sharedInstance.string(from: NSNumber(value: assetList[index].quantity))!
    }
    
    func getValueForAsset(_ index: Int) -> Float {
        return assetList[index].getValue()
    }
    
    func getValueForAssetFormatted(_ index: Int) -> String {
        return CurrencyFormatter.sharedInstance.string(from: NSNumber(value: assetList[index].getValue()))!
    }
    
    func getTotalValue() -> Float {
        var total: Float = 0.0
        for item in assetList {
            if item.getValue() != -1 {
                total += item.getValue()
            }
        }
        return total
    }
    
    
    // MARK: - SORT methods to display portfolio in a certain order
    /** Cycle sort methods. */
    func sortCycle() {
        // Update model with new sorting method
        sortMethod =  SortMethod(rawValue: (sortMethod.rawValue + 1) % _maxSortMethods)!
        sortByMethod(aSortMethod: sortMethod)
    }
    
    func sortByMethod(aSortMethod: SortMethod) {
        sortMethod = aSortMethod
        
        switch aSortMethod {
        case SortMethod.Name:
            sortByName()
        case SortMethod.Price:
            sortByPrice()
        case SortMethod.Quantity:
            sortByQuantity()
        case SortMethod.Value:
            sortByValue()
        case SortMethod.Percent:
            sortByPercent()
        }
        
        // Inform delegates
        delegate?.portfolioDidChangeSortMethod(
            self, sortMethod: aSortMethod)
        
        // Tell portfolio controller to reload table
        delegate?.portfolioDidUpdateData(self)
    }
    
    private func sortByName() {
        assetList.sort(by: {$0.name < $1.name})
    }
    
    private func sortByPrice() {
        assetList.sort(by: {$0.price > $1.price})
    }
    
    private func sortByQuantity() {
        assetList.sort(by: {$0.quantity > $1.quantity})
    }
    
    private func sortByValue() {
        assetList.sort(by: {$0.getValue() > $1.getValue()})
    }
    
    private func sortByPercent() {
        assetList.sort(by: {$0.percentChange > $1.percentChange})
    }
    
    
    
    // MARK: - Delegate methods for Asset model
    
    /** Returns the price of the asset _currencySymbol_ from the ticker. */
    func assetDidRequestAssetPrice(_ asset: Asset, currencySymbol: CurrencySymbol) -> Float {
        // Get prices
        let pricePerTicker = myTickerListController.getPricesForAsset(currencySymbol.rawValue)
        
        // TODO: for now we just get the first pair, Poloniex. But we could
        // choose other exchanges and compute averages and so =D
        return pricePerTicker.first!.1
    }
    
    
    
    // MARK: - Methods to manage portfolio data persistence
    
    func savePortfolioData() {
        _portfolioDataController.savePortfolioDataToDisk(portfolioData: generatePortfolioDataForPersistence())
    }
    
    
    
    func generatePortfolioDataForPersistence() -> NSMutableDictionary {
        let portfolioDict: NSMutableDictionary = NSMutableDictionary()
        
        for anAsset in assetList {
            let assetDict: NSMutableDictionary = NSMutableDictionary()
            
            assetDict.setValue(anAsset.quantity, forKey: "quantity")
            portfolioDict.setObject(assetDict, forKey: anAsset.name as NSCopying)
        }
        
        return portfolioDict
    }
    
}




//  o--o  o--o   o-o  o-O-o  o-o    o-o  o-o  o     o-o
//  |   | |   | o   o   |   o   o  /    o   o |    |
//  O--o  O-Oo  |   |   |   |   | O     |   | |     o-o
//  |     |  \  o   o   |   o   o  \    o   o |        |
//  o     o   o  o-o    o    o-o    o-o  o-o  O---oo--o
//
// MARK: - Delegate methods for the Portfolio

protocol PortfolioDelegate {
    func portfolioDidUpdateData (_ portfolio: Portfolio)
    func portfolioDidChangeSortMethod(_ portfolio: Portfolio, sortMethod aSortMethod: SortMethod)
}



// MARK: - Enums
enum SortMethod: Int {
    case Name = 0
    case Price = 1
    case Quantity = 2
    case Percent = 3
    case Value = 4
    
    static let count: Int = {
        var max: Int = 0
        while let _ = SortMethod(rawValue: max) { max += 1 }
        return max
    }()
}
