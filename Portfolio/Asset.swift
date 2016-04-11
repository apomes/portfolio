//
//  AssetModel.swift
//  Portfolio
//
//  Created by Ausias on 01/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation

/** Asset model. */
class Asset {
    
    /** The full name of the asset. Ex. Dogecoin */
    var name:String
    
    /** The abreviated name of the asset used in tickers. Ex. DOGE */
    var tickerSymbol:String?
    
    /** Quantity of the asset. */
    var quantity: Float
    
    /** Price of the asset. */
    var price: Float
    
    
    
    init(name: String, quantity: Float) {
        self.name = name
        self.quantity = quantity
        self.price = 0.0
    }
    
    
}