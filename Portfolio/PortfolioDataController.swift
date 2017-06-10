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
    
    let portfolioFilename: String = "PortfolioData"
    
    
    override init () {
        super.init()

        // getting path to GameData.plist
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0) as! NSString
        let path = documentsDirectory.appendingPathComponent(portfolioFilename + ".plist")
        
        let fileManager = FileManager.default
        
        //check if file exists
        if !fileManager.fileExists(atPath: path) {
            guard let bundlePath = Bundle.main.path(forResource: portfolioFilename, ofType: "plist") else { return }
            
            do {
                try fileManager.copyItem(atPath: bundlePath, toPath: path)
            } catch let error as NSError {
                print("Unable to copy file. ERROR: \(error.localizedDescription)")
            }
        }
        
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
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0) as! NSString
        let path = documentsDirectory.appendingPathComponent(portfolioFilename + ".plist")
        
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
