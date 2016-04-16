//
//  ApiKeys.swift
//  Portfolio
//
//  Created by Ausias on 16/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation



/** Extracts the API keys values from a plist file.  */
func valueForAPIKey(keyname keyname:String) -> AnyObject {
    
    let filePath = NSBundle.mainBundle().pathForResource("ApiKeys", ofType:"plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let value:AnyObject = (plist?.objectForKey(keyname))!
    
    return value
}