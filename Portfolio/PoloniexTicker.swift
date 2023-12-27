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
    
    let base_url: String = "https://api.poloniex.com/"
    
    // Structure to store decoded json data for coin price request
    struct CoinData: Codable {
        let symbol: String
        let price: String
        let time: Int
        let dailyChange: String
        let ts: Int
    }
    
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
    
    
    
    func returnTicker(_ callback: @escaping ([[String: Any]], String?) -> Void) 
    {
        self.api_query("markets/price", req: nil) { (data, error) -> Void in
            if let error = error {
                callback([[:]], error)
            } else {
                do {
                    // Convert string to json
                    let jsonData = try self.convertStringToJSON(data)
                    callback(jsonData, nil)
                } catch {
                    callback([[:]], error.localizedDescription)
                }
            }
        }
    }
    
    
    
    fileprivate func api_query(_ command: String, req: [String: String]?, callback: @escaping (String, String?) -> Void) {
        if command == "markets/price" {
            executeHttpRequest(base_url + command) {
                (data, error) -> Void in
                if error != nil {
                    callback("", error)
                } else {
                    callback(data, nil)
                }
            }
        }
        else {
            executeHttpRequest(base_url + command) {
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
        httpGet(request as URLRequest) {
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
    
    
    fileprivate func convertStringToJSON(_ jsonString: String) throws -> [[String: Any]] {
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            throw NSError(domain: "JSONConvertErrorDomain", code: 1, userInfo: ["message": "Failed to convert string to data"])
        }
        
        do {
//            print(String(data: jsonData, encoding: .utf8) ?? "Invalid JSON Data")

            if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]] {
                return jsonObject
            } else {
                throw NSError(domain: "JSONConvertErrorDomain", code: 2, userInfo: ["message": "Failed to convert data to JSON dictionary"])
            }
            
        } catch {
            throw error
        }
    }


    
//    fileprivate func convertStringToJSON (_ jsonString: String) -> [String: AnyObject] {
//        let jsondata: Data = jsonString.data(using: String.Encoding.utf8)!
//        var json: [String: AnyObject] = [:]
//        do {
//            json = try JSONSerialization.jsonObject(with: jsondata, options: JSONSerialization.ReadingOptions()) as! [String: AnyObject]
//        } catch {
//            print(error)
//        }
//        return json
//    }
    
}
