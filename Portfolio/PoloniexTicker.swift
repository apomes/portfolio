//
//  Poloniex.swift
//  Portfolio
//
//  Created by Ausias on 12/03/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import Foundation

class PoloniexTicker {
    
    var APIKey: String
    var Secret: String
    
    let base_url: String = "https://poloniex.com/public?command="
    
    
    
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
    
    
    
    func returnTicker(_ callback: @escaping ([String: AnyObject], String?) -> Void) {
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
    
    
    
    fileprivate func api_query(_ command: String, req: [String: String]?, callback: @escaping (String, String?) -> Void) {
        if command == "returnTicker" || command == "return24hVolume" {
            executeHttpRequest(base_url + command) {
                (data, error) -> Void in
                if error != nil {
                    callback("", error)
                } else {
                    callback(data, nil)
                }
            }
        }
        else if command == "returnOrderBook" {
            executeHttpRequest(base_url + command +
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
    
    
    
    fileprivate func executeHttpRequest(_ request: String, callback: @escaping (String, String?) -> Void) {
        let request = NSMutableURLRequest(url: URL(string: request)!)
        httpGet(request as URLRequest!) {
            (data, error) -> Void in
            if error != nil {
                callback("", error)
            } else {
                callback(data, nil)
            }
        }
    }
    
    
    
    fileprivate func httpGet(_ request: URLRequest!, callback: @escaping (String, String?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            if error != nil {
                callback("", error!.localizedDescription)
            } else {
                let result = NSString(data: data!, encoding:
                    String.Encoding.ascii.rawValue)!
                callback(result as String, nil)
            }
        })
        task.resume()
    }
    
    
    
    fileprivate func convertStringToJSON (_ jsonString: String) -> [String: AnyObject] {
        let jsondata: Data = jsonString.data(using: String.Encoding.utf8)!
        var json: [String: AnyObject] = [:]
        do {
            json = try JSONSerialization.jsonObject(with: jsondata, options: JSONSerialization.ReadingOptions()) as! [String: AnyObject]
        } catch {
            print(error)
        }
        return json
    }
    
}
