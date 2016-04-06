//
//  PortfolioModel.swift
//  Portfolio
//
//  Created by Ausias on 31/03/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation


/** Portfolio table model. */
class Portfolio {
    
    /** List of assets. */
    var assetList:[Asset]
    
    
    init () {
        // Empty portfolio
        assetList = []
    }
    
    
    
    /**
     Adds new asset to the portfolio. 
     
     - parameters:
        - name: full name of the asset.
        - value: quantity of the asset.
     */
    func addAsset(name:String, value:Float) {
        let anAsset = Asset(name: name, value: value)
        assetList.append(anAsset)
    }
    
    
    
    func numberOfAssets() -> Int {
        return assetList.count
    }
    
    
    
    func getNameForAsset(index: Int) -> String {
        return assetList[index].name
    }
    
}