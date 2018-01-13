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

    func getSymbolForName(_ name: String) -> CurrencySymbol {
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
        case "Bitcoin", "BTC":
            currencySymbol = CurrencySymbol.Bitcoin
        case "Litecoin":
            currencySymbol = CurrencySymbol.Litecoin
        case "Gems", "GetGems", "Gemz":
            currencySymbol = CurrencySymbol.Gemz
        case "LTBCoin":
            currencySymbol = CurrencySymbol.LTBCoin
        case "Lumen":
            currencySymbol = CurrencySymbol.Lumen
        case "Storj":
            currencySymbol = CurrencySymbol.Storj
        case "Zcash":
            currencySymbol = CurrencySymbol.Zcash
        case "Augur":
            currencySymbol = CurrencySymbol.Augur
        case "Ethereum Classic":
            currencySymbol = CurrencySymbol.EthereumClassic
        case "Monero":
            currencySymbol = CurrencySymbol.Monero
        case "Bitcoin Cash":
            currencySymbol = CurrencySymbol.BitcoinCash
            
        case "USD", "USDT":
            currencySymbol = CurrencySymbol.Dollar
        case "EUR":
            currencySymbol = CurrencySymbol.Euro
        case "GBP":
            currencySymbol = CurrencySymbol.Pound
            
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
    case Lumen = "STR"
    case Storj = "STORJ"
    case Zcash = "ZEC"
    case Augur = "REP"
    case EthereumClassic = "ETC"
    case Monero = "XMR"
    case BitcoinCash = "BCH"
    
}
