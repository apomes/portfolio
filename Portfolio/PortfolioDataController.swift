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
    
    override init () {
        super.init()

        let path = NSBundle.mainBundle().pathForResource("PortfolioData", ofType: "plist")!
        let plistURL: NSURL = NSURL.fileURLWithPath(path)
        
        let err: NSErrorPointer = nil
        if plistURL.checkResourceIsReachableAndReturnError(err) {
            print(plistURL)
            
            let plistData = NSFileManager.defaultManager().contentsAtPath(plistURL.path!)
            
            var plistDictionary: NSDictionary
            do {
                plistDictionary = try NSPropertyListSerialization.propertyListWithData(plistData!, options: NSPropertyListReadOptions.Immutable, format: nil) as! NSDictionary
                
                portfolioData = NSMutableDictionary.init(dictionary: plistDictionary)
                
            }
            catch {
                print("Error deserializing plist.")
            }
        }
    }
    

}




/** Enums to manage errors in our code. */
enum DataControllerError: ErrorType {
    case SerializationError
}