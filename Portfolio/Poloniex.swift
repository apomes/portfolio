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
    
    
    
    
    
    private func api_query(command: String, req: [String: String]?) {
        if command == "returnTicker" || command == "return24hVolume" {
            executeHttpRequest("https://poloniex.com/public?command=" + command)
        }
        else if command == "returnOrderBook" {
            executeHttpRequest("http://poloniex.com/public?command=" + command +
                "&currencyPair=" + req!["currencyPair"]!)
        }
    }
    
    
    
    func returnTicker() {
        self.api_query("returnTicker", req: nil)
    }
    
    
    
    private func executeHttpRequest(request: String) {
        let request = NSMutableURLRequest(URL: NSURL(string: request)!)
        httpGet(request){
            (data, error) -> Void in
            if error != nil {
                print(error)
            } else {
                print(data)
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
    
}