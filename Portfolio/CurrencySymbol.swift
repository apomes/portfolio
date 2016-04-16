//
//  CurrencyType.swift
//  Portfolio
//
//  Created by Ausias on 09/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation


/** Currencies and their ticker symbol. */
enum CurrencySymbol: String {
    
    // Fiat currencies
    case Dollar = "USD"
    case Euro = "EUR"
    case Pound = "GBP"
    case CanadianDollar = "CAD"
    case AustralianDollar = "AUD"
    
    // Cryptocurrencies
    case Bitcoin = "BTC"
    case Ether = "ETH"
    case Litecoin = "LTC"
    case Dogecoin = "DOGE"
    case Factom = "FCT"
    case Dash = "DASH"
    case Counterparty = "XCP"
    
}