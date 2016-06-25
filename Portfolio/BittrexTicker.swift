//
//  BittrexTicker.swift
//  Portfolio
//
//  Created by Ausias on 10/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation

class BittrexTicker {
    
    // TODO: The key, secret and the init method could probably go into a base Ticker class.
    var APIKey: String
    var Secret: String
    
    let public_base_url: String = "https://bittrex.com/api/v1.1/public/"
//    let market_base_url: String = "https://bittrex.com/api/v1.1/market/"
//    let account_base_url: String = "https://bittrex.com/api/v1.1/account/"
    
    
    /**
     Inits the Bittrex class with authentication parameters.
     
     This initializer gets and API key and the Secret and stores them in the
     corresponding member variables.
     
     - parameter aPIKey: The API key to authentiate with Bittrex.
     - parameter Secret: The Secret to authenticate with Bittrex.
     */
    init(withAPIKey aPIKey: String, withSecret secret: String) {
        self.APIKey = aPIKey
        self.Secret = secret
    }
    
    
    
    func returnTicker(callback: ([String: AnyObject], String?) -> Void) {
        self.api_query("getmarketsummaries", req: nil) {
            (data, error) -> Void in
            if error != nil {
                callback([:], error)
            } else {
                // Convert string to json
                let jsonData = self.convertStringToJSON(data)
                
                print(jsonData["result"]![0])
                
                callback(jsonData, nil)
            }
        }
    }
    
    
    
    private func api_query(command: String, req: [String: String]?, callback: (String, String?) -> Void) {
        if command == "getmarketsummaries" {
            executeHttpRequest(public_base_url + command) {
                (data, error) -> Void in
                if error != nil {
                    callback("", error)
                } else {
                    callback(data, nil)
                }
            }
        }
        else if command == "getorderbook" {
            executeHttpRequest(public_base_url + command +
                "&currencyPair=" + req!["currencyPair"]!) {
                    (data, error) -> Void in
                    if error != nil {
                        callback("", error)
                    } else {
                        callback(data, nil)
                    }
            }
        }
    }
    
    
    
    private func executeHttpRequest(request: String, callback: (String, String?) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: request)!)
        httpGet(request) {
            (data, error) -> Void in
            if error != nil {
                callback("", error)
            } else {
                callback(data, nil)
            }
        }
    }
    
    
    
    private func httpGet(request: NSURLRequest!, callback: (String, String?) -> Void) {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if error != nil {
                callback("", error!.localizedDescription)
            } else {
                let result = NSString(data: data!, encoding:
                    NSASCIIStringEncoding)!
                callback(result as String, nil)
            }
        }
        task.resume()
    }
    
    
    
    private func convertStringToJSON (jsonString: String) -> [String: AnyObject] {
        let jsondata: NSData = jsonString.dataUsingEncoding(NSUTF8StringEncoding)!
        var json: [String: AnyObject] = [:]
        do {
            json = try NSJSONSerialization.JSONObjectWithData(jsondata, options: NSJSONReadingOptions()) as! [String: AnyObject]
        } catch {
            print(error)
        }
        return json
    }
}