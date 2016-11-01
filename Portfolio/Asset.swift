//
//  AssetModel.swift
//  Portfolio
//
//  Created by Ausias on 01/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation
import UIKit

/** Asset model. */
class Asset {
    
    var delegate: Portfolio?
    
    /** The full name of the asset. Ex. Dogecoin */
    var name:String

    /** Currency we are monitoring in the asset. */
    var baseCurrency: CurrencySymbol?
    
    /** Currency used as the reference. Usually EUR, USD, BTC, ... */
    var counterCurrency: CurrencySymbol?
    
    /** Quantity of the asset. */
    var quantity: Float
    
    /** Last price (exchange rate) of the base currency in terms of the counter currency. */
    var price: Float
    
    /** Last percent change in the value of the asset. */
    var percentChange: Float
    
    
    
    init(name: String, quantity: Float) {
        self.name = name
        self.quantity = quantity
        self.price = 0.0
        self.percentChange = 0.0
    }
    
    
    
    /** Returns the total value of the asset. */
    func getValue() -> Float {
        var value: Float = -1
        if price >= 0 {
            value = quantity * price
            if counterCurrency == CurrencySymbol.Bitcoin {
                // Get price of bitcoin from ticker to compute value in $
                value *= (delegate?.assetDidRequestAssetPrice(self, currencySymbol: CurrencySymbol.Bitcoin))!
            }
        }
        
        return value
    }
    
}



//  o--o  o--o   o-o  o-O-o  o-o    o-o  o-o  o     o-o
//  |   | |   | o   o   |   o   o  /    o   o |    |
//  O--o  O-Oo  |   |   |   |   | O     |   | |     o-o
//  |     |  \  o   o   |   o   o  \    o   o |        |
//  o     o   o  o-o    o    o-o    o-o  o-o  O---oo--o
//
// MARK: - Delegate methods for the Asset

protocol AssetDelegate {
    func assetDidRequestAssetPrice(_ asset: Asset, currencySymbol: CurrencySymbol) -> Float
}
