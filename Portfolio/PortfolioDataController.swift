//
//  PortfolioData.swift
//  Portfolio
//
//  Created by Ausias on 01/05/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//
//  Purpose: It manages data persistence. Writes and loads from disk.


import Foundation

class PortfolioDataController: NSObject {
    
    var portfolioData: NSMutableDictionary?
    
    let portfolioFilename: String = "PortfolioDataDemo"
    
    
    override init () {
        super.init()

        let path = Bundle.main.path(forResource: portfolioFilename, ofType: "plist")!
        let plistURL: URL = URL(fileURLWithPath: path)
                
        do {
            let haveResource: Bool = try plistURL.checkResourceIsReachable()
            
            if haveResource {
                let plistData = FileManager.default.contents(atPath: plistURL.path)
                
                var plistDictionary: NSDictionary
                do {
                    plistDictionary = try PropertyListSerialization.propertyList(from: plistData!, options: PropertyListSerialization.MutabilityOptions(), format: nil) as! NSDictionary
                    
                    portfolioData = NSMutableDictionary.init(dictionary: plistDictionary)
                }
                catch {
                    print("Error deserializing plist.")
                }
            }
        } catch {
            print("Error: PortfolioData resource is not available.")
        }
    }
    
    
    
    func savePortfolioDataToDisk (portfolioData: NSMutableDictionary) {
//        var error: String
        let path = Bundle.main.path(forResource: portfolioFilename, ofType: "plist")!
        let plistURL: URL = URL(fileURLWithPath: path)
        
        do {
            let plistData: NSData? = try PropertyListSerialization.data(fromPropertyList: portfolioData, format: .xml, options: 0) as NSData?
            
            if plistData != nil {
                plistData!.write(to: plistURL, atomically: true)
            }
        } catch {
            print("Error serializing data.")
        }
    }
}




/** Enums to manage errors in our code. */
enum DataControllerError: Error {
    case serializationError
}
