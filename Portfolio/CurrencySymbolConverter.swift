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
        case "Bitcoin Cash SV":
            currencySymbol = CurrencySymbol.BitcoinSatoshiVision
        case "Bitcoin Cash ABC":
            currencySymbol = CurrencySymbol.BitcoinCashABC
        case "Decentraland":
            currencySymbol = CurrencySymbol.Decentraland
        case "Ripple":
            currencySymbol = CurrencySymbol.Ripple
        case "Tezos":
            currencySymbol = CurrencySymbol.Tezos
        case "Polkadot":
            currencySymbol = CurrencySymbol.Polkadot
        case "Basic Attention Token":
            currencySymbol = CurrencySymbol.Bat
        case "BitTorrent":
            currencySymbol = CurrencySymbol.BitTorrent
        case "Tron":
            currencySymbol = CurrencySymbol.Tron
        case "Filecoin":
            currencySymbol = CurrencySymbol.Filecoin
        case "Cardano":
            currencySymbol = CurrencySymbol.Cardano
            
        case "USD", "USDT", "USDC":
            currencySymbol = CurrencySymbol.Dollar
        case "EUR":
            currencySymbol = CurrencySymbol.Euro
        case "GBP":
            currencySymbol = CurrencySymbol.Pound
            
        default:
            currencySymbol = CurrencySymbol.Dollar
        }
        
        return currencySymbol
    }
}



/** Currencies and their ticker symbol. */
enum CurrencySymbol: String {
    
    // Fiat currencies
    case Dollar = "USDT"
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
    case BitcoinCashABC = "BCHA"
    case BitcoinSatoshiVision = "BCHSV"
    case Decentraland = "MANA"
    case Ripple = "XRP"
    case Tezos = "XTZ"
    case Polkadot = "DOT"
    case Bat = "BAT"
    case BitTorrent = "BTT"
    case Tron = "TRX"
    case Filecoin = "FIL"
    case Cardano = "ADA"
    
}
