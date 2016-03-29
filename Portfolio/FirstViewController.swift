//
//  FirstViewController.swift
//  Portfolio
//
//  Created by Ausias on 12/03/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController, UIScrollViewDelegate {

    let APIKey: String = "VJC0L8L2-UDFKQDZZ-CL9V2XGZ-07ZCJVS5"
    let Secret: String = "eb93db31bf5a5b531186154676a8e5b4939c13c13bd26666ef46717/b58d7e4e9bd12a5d11aba8db9d012f4417c3ff2a495504fc45dff61156f4ed3eb130a93db"
    
    // Init the poloniex wrapper
    var poloniexWrapper: Poloniex!
    
    var poloniexTicker: [String: AnyObject] = [:] {
        didSet {
            print("Poloniex ticker updated!")
            
            // Update ticker model
            updateTickerModel()
        }
    }
    
    
    @IBOutlet weak var tickersScrollView: UIScrollView!
    
    @IBOutlet weak var dashView: UIView!
    @IBOutlet weak var factomView: UIView!
    @IBOutlet weak var ethereumView: UIView!
    @IBOutlet weak var counterpartyView: UIView!
    
    @IBOutlet weak var LastValueDASH: UILabel!
    @IBOutlet weak var SavingsDASH: UILabel!
    @IBOutlet weak var LastValueFCT: UILabel!
    @IBOutlet weak var SavingsFCT: UILabel!
    @IBOutlet weak var LastValueETH: UILabel!
    @IBOutlet weak var SavingsETH: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Init poloniex wrapper
        poloniexWrapper = Poloniex(withAPIKey: APIKey, withSecret: Secret)
        
        getTickerData()
        
        // Init background color for views to black
        dashView.backgroundColor = UIColor.blackColor()
        factomView.backgroundColor = UIColor.blackColor()
        ethereumView.backgroundColor = UIColor.blackColor()
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    private func getTickerData() {
        // Get ticker
        poloniexWrapper.returnTicker() {
            (data, error) -> Void in
            if error != nil {
                print(error)
            } else {
                self.poloniexTicker = data
            }
        }
    }
    
    
    
    func updateTickerModel() {
        // Set up number formatter with significant digits
        let formatter: NSNumberFormatter = NSNumberFormatter()
        formatter.locale = NSLocale.currentLocale()
        formatter.allowsFloats = true
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        // Makes formatter use maximumSignificantDigits
        formatter.usesSignificantDigits = true
        formatter.minimumSignificantDigits = 2
        formatter.maximumSignificantDigits = 3
        
        
        let factomTicker = poloniexTicker["BTC_FCT"]!
        let dashTicker = poloniexTicker["BTC_DASH"]!
        let ethTicker = poloniexTicker["BTC_ETH"]!
        let xcpTicker = poloniexTicker["BTC_XCP"]!
        let btcPrice: Float = Float(poloniexTicker["USDT_BTC"]!["last"]! as! String)!
        let ethPrice: Float = Float(poloniexTicker["USDT_ETH"]!["last"]! as! String)!
        
        print("1 BTC = $\(btcPrice)")
        
        // TODO: implement proper update of fields using SetNeedsDisplay and so on
        dispatch_async(dispatch_get_main_queue(), {
            let lastDASH: Float = Float((dashTicker["last"]!)! as! String)!
            self.LastValueDASH.text = formatter.stringFromNumber(lastDASH)
            self.SavingsDASH.text = "\(lastDASH * 101 * btcPrice)"
            let dashPercentChange: Float = Float(dashTicker["percentChange"] as! String)! * 100
            let dashColor: CGFloat = sqrt(CGFloat(abs(dashPercentChange/100.0)))
            if dashPercentChange >= 0 {
                self.dashView.backgroundColor = UIColor.init(red: 0, green: dashColor, blue: 0, alpha: 1)
            }
            else {
                self.dashView.backgroundColor = UIColor.init(red: dashColor, green: 0, blue: 0, alpha: 1)
            }
            
            
            let lastFCT: Float = Float((factomTicker["last"]!)! as! String)!
            self.LastValueFCT.text = formatter.stringFromNumber(lastFCT)
            self.SavingsFCT.text = "\(lastFCT * 200.0 * btcPrice)"
            let factomPercentChange: Float = Float(factomTicker["percentChange"] as! String)! * 100
            let factomColor: CGFloat = sqrt(CGFloat(abs(factomPercentChange/100.0)))
            if factomPercentChange >= 0 {
                self.factomView.backgroundColor = UIColor.init(red: 0, green: factomColor, blue: 0, alpha: 1)
            }
            else {
                self.factomView.backgroundColor = UIColor.init(red: factomColor, green: 0, blue: 0, alpha: 1)
            }
            
            
            let lastETH: Float = Float((ethTicker["last"]!)! as! String)!
            self.LastValueETH.text = formatter.stringFromNumber(lastETH)
            self.SavingsETH.text = "$\(formatter.stringFromNumber(ethPrice)!)"
            let ethPercentChange: Float = Float(ethTicker["percentChange"] as! String)! * 100
            let ethColor: CGFloat = sqrt(CGFloat(abs(ethPercentChange/100.0)))
            if ethPercentChange >= 0 {
                self.ethereumView.backgroundColor = UIColor.init(red: 0, green: ethColor, blue: 0, alpha: 1)
            }
            else {
                self.ethereumView.backgroundColor = UIColor.init(red: ethColor, green: 0, blue: 0, alpha: 1)
            }
            
            
            let lastXCP: Float = Float((xcpTicker["last"]!)! as! String)!
            self.LastValueXCP.text = formatter.stringFromNumber(lastXCP)
            self.SavingsXCP.text = "$\(lastXCP * 175 * btcPrice)"
            let xcpPercentChange: Float = Float(xcpTicker["percentChange"] as! String)! * 100
            let xcpColor: CGFloat = sqrt(CGFloat(abs(xcpPercentChange/100.0)))
            if xcpPercentChange >= 0 {
                self.counterpartyView.backgroundColor = UIColor.init(red: 0, green: xcpColor, blue: 0, alpha: 1)
            }
            else {
                self.counterpartyView.backgroundColor = UIColor.init(red: xcpColor, green: 0, blue: 0, alpha: 1)
            }
        })
        
        //print(poloniexTicker)
    }
    
    
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        getTickerData()
    }

}

