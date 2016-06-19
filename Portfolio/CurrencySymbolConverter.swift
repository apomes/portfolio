//
//  CurrencyType.swift
//  Portfolio
//
//  Created by Ausias on 09/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation


/** Singleton class to convert from currency names to currency symbols. */
class CurrencySymbolConverter {
    static let sharedInstance = CurrencySymbolConverter()

    func getSymbolForName(name: String) -> CurrencySymbol {
        var currencySymbol: CurrencySymbol
        switch name {
        case "Factom":
            currencySymbol = CurrencySymbol.Factom
        case "Counterparty":
            currencySymbol = CurrencySymbol.Counterparty
        case "Ethereum", "Ether":
            currencySymbol = CurrencySymbol.Ether
        case "Dash":
            currencySymbol = CurrencySymbol.Dash
        case "Dogecoin":
            currencySymbol = CurrencySymbol.Dogecoin
        case "Voxel":
            currencySymbol = CurrencySymbol.Voxel
        case "Lisk":
            currencySymbol = CurrencySymbol.Lisk
        case "DAO":
            currencySymbol = CurrencySymbol.DAO
        case "Bitcoin", "BTC":
            currencySymbol = CurrencySymbol.Bitcoin
        case "Litecoin":
            currencySymbol = CurrencySymbol.Litecoin
        case "Gems", "GetGems", "Gemz":
            currencySymbol = CurrencySymbol.Gemz
        case "LTBCoin":
            currencySymbol = CurrencySymbol.LTBCoin
        case "USD", "USDT":
            currencySymbol = CurrencySymbol.Dollar
        default:
            currencySymbol = CurrencySymbol.Bitcoin
        }
        
        return currencySymbol
    }
}



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
    case Gemz = "GEMZ"
    case LTBCoin = "LTBC"
    case Voxel = "VOX"
    case Lisk = "LSK"
    case DAO = "DAO"
    
}