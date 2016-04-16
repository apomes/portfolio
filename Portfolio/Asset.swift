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
    
    /** The abreviated name of the asset used in tickers. Ex. DOGE */
    var tickerSymbol:String?
    
    /** Quantity of the asset. */
    var quantity: Float
    
    /** Last price of the asset. */
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
        return quantity * price
    }
    
}