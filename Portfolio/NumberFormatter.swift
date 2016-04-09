//
//  NumberFormatter.swift
//  Portfolio
//
//  Created by Ausias on 09/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//  
//  Description: Classes to format numbers

import Foundation



/** Formatter singleton class for currencies. */
class CurrencyFormatter: NSNumberFormatter {
    static let sharedInstance = CurrencyFormatter()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        self.locale = NSLocale.currentLocale()
        self.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        self.alwaysShowsDecimalSeparator = true
    }
}



/** Formatter singleton class for general numbers. */
class GeneralFormatter: NSNumberFormatter {
    static let sharedInstance = GeneralFormatter()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        self.locale = NSLocale.currentLocale()
        self.allowsFloats = true
        self.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        // Makes formatter use maximumSignificantDigits
        self.usesSignificantDigits = true
        self.minimumSignificantDigits = 2
        self.maximumSignificantDigits = 3
    }
}