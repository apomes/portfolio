//
//  FirstViewController.swift
//  Portfolio
//
//  Created by Ausias on 12/03/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    let APIKey: String = "VJC0L8L2-UDFKQDZZ-CL9V2XGZ-07ZCJVS5"
    let Secret: String = "eb93db31bf5a5b531186154676a8e5b4939c13c13bd26666ef46717/b58d7e4e9bd12a5d11aba8db9d012f4417c3ff2a495504fc45dff61156f4ed3eb130a93db"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Init the poloniex wrapper
        let poloniexWrapper: Poloniex = Poloniex(withAPIKey: APIKey, withSecret: Secret)
        
        // Get ticker
        poloniexWrapper.returnTicker()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    


}

