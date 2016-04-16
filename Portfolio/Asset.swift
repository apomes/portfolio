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
    
    /** The full name of the asset. Ex. Dogecoin */
    var name:String

    /** Currency we are monitoring in the asset. */
    var baseCurrencySymbol: String
    
    /** Currency used as the reference. Usually EUR, USD, BTC, ... */
    var counterCurrencySymbol: String
    
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
        self.baseCurrencySymbol = ""
        self.counterCurrencySymbol = ""
    }
    
    
    
    /** Returns the total value of the asset. */
    func getValue() -> Float {
        return quantity * price
    }
    
}