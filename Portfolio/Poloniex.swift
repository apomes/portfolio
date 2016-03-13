//
//  Poloniex.swift
//  Portfolio
//
//  Created by Ausias on 12/03/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation

class Poloniex {
    
    var APIKey: String
    var Secret: String
    
    
    
    /**
     Inits the Poloniex class with authentication parameters.
     
     This initializer gets and API key and the Secret and stores them in the 
     corresponding member variables.
     
     - parameter aPIKey: The API key to authentiate with Poloniex.
     - parameter Secret: The Secret to authenticate with Poloniex.
     */
    init(withAPIKey aPIKey: String, withSecret secret: String) {
        self.APIKey = aPIKey
        self.Secret = secret
    }
    
    
    
    func returnTicker(callback: ([String: AnyObject], String?) -> Void) {
        self.api_query("returnTicker", req: nil) {
            (data, error) -> Void in
            if error != nil {
                callback([:], error)
            } else {
                // Convert string to json
                let jsonData = self.convertStringToJSON(data)
                
                callback(jsonData, nil)
            }
        }
    }
    
    
    
    private func api_query(command: String, req: [String: String]?, callback: (String, String?) -> Void) {
        if command == "returnTicker" || command == "return24hVolume" {
            executeHttpRequest("https://poloniex.com/public?command=" + command) {
                (data, error) -> Void in
                if error != nil {
                    callback("", error)
                } else {
                    callback(data, nil)
                }
            }
        }
        else if command == "returnOrderBook" {
            executeHttpRequest("http://poloniex.com/public?command=" + command +
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