//
//  NumberFormatter.swift
//  Portfolio
//
//  Created by Ausias on 09/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//  
//  Description: Classes to format numbers

import Foundation



/** Formatter singleton class for general numbers. */
class NumberFormatter: Foundation.NumberFormatter {
    static let sharedInstance = NumberFormatter()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        self.locale = Locale.current
        self.allowsFloats = true
        self.numberStyle = Foundation.NumberFormatter.Style.decimal
        
        // Makes formatter use maximumSignificantDigits
        self.usesSignificantDigits = true
        self.minimumSignificantDigits = 2
        self.maximumSignificantDigits = 3
    }
}



/** Formatter singleton class for currencies. */
class CurrencyFormatter: Foundation.NumberFormatter {
    static let sharedInstance = CurrencyFormatter()
    
    /** Currently selected locale that determines the currency symbol. */
    var selectedLocale: String = "en_US" {
        didSet {
            self.locale = Locale.init(identifier: selectedLocale)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        self.locale = Locale.init(identifier: selectedLocale)
        self.numberStyle = Foundation.NumberFormatter.Style.currency
        self.alwaysShowsDecimalSeparator = true
    }
}
