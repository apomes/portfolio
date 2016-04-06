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
    var value: Float
    
    
    
    init(name: String, value: Float) {
        self.name = name
        self.value = value
    }
    
    
}