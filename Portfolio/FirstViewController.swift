//
//  FirstViewController.swift
//  Portfolio
//
//  Created by Ausias on 12/03/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController, UIScrollViewDelegate {

    let APIKey: String = apiKeyForTicker(tickerType: TickerType.Poloniex) 
    let Secret: String = apiSecretForTicker(tickerType: TickerType.Poloniex) 
    
    // Init the poloniex wrapper
    var poloniexWrapper: PoloniexTicker!
    
    var poloniexTicker: [String: AnyObject] = [:] {
        didSet {
            print("Poloniex ticker updated!")
            
            // Update ticker model
            updateTickerModel()
        }
    }
    
    @IBAction func DonePressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var tickersScrollView: UIScrollView!
    
    @IBOutlet weak var dashView: UIView!
    @IBOutlet weak var factomView: UIView!
    @IBOutlet weak var ethereumView: UIView!
    @IBOutlet weak var counterpartyView: UIView!
    @IBOutlet weak var dogeView: UIView!
    
    @IBOutlet weak var LastValueDASH: UILabel!
    @IBOutlet weak var SavingsDASH: UILabel!
    @IBOutlet weak var LastValueFCT: UILabel!
    @IBOutlet weak var SavingsFCT: UILabel!
    @IBOutlet weak var LastValueETH: UILabel!
    @IBOutlet weak var SavingsETH: UILabel!
    @IBOutlet weak var LastValueXCP: UILabel!
    @IBOutlet weak var SavingsXCP: UILabel!
    @IBOutlet weak var LastValueDOGE: UILabel!
    @IBOutlet weak var SavingsDOGE: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        

        // Init poloniex wrapper
        
        
        poloniexWrapper = PoloniexTicker(withAPIKey: APIKey, withSecret: Secret)
        
        getTickerData()
        
        // Init background color for views to black
        dashView.backgroundColor = UIColor.black
        factomView.backgroundColor = UIColor.black
        ethereumView.backgroundColor = UIColor.black
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    fileprivate func getTickerData() {
        // Get ticker
        poloniexWrapper.returnTicker() {
            (data, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                self.poloniexTicker = data
            }
        }
    }
    
    
    
    func updateTickerModel() {
        // Set up number formatter with significant digits
        let formatter: Foundation.NumberFormatter = Foundation.NumberFormatter()
        formatter.locale = Locale.current
        formatter.allowsFloats = true
        formatter.numberStyle = Foundation.NumberFormatter.Style.decimal
        
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
        let dogeTicker = poloniexTicker["BTC_DOGE"]!
        
        print("1 BTC = $\(btcPrice)")
        
        // TODO: implement proper update of fields using SetNeedsDisplay and so on
        DispatchQueue.main.async(execute: {
            let lastDASH: Float = Float((dashTicker["last"]!)! as! String)!
            self.LastValueDASH.text = formatter.string(from: NSNumber(value: lastDASH))
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
            self.LastValueFCT.text = formatter.string(from: NSNumber(value: lastFCT))
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
            self.LastValueETH.text = formatter.string(from: NSNumber(value: lastETH))
            self.SavingsETH.text = "$\(formatter.string(from: NSNumber(value: ethPrice))!)"
            let ethPercentChange: Float = Float(ethTicker["percentChange"] as! String)! * 100
            let ethColor: CGFloat = sqrt(CGFloat(abs(ethPercentChange/100.0)))
            if ethPercentChange >= 0 {
                self.ethereumView.backgroundColor = UIColor.init(red: 0, green: ethColor, blue: 0, alpha: 1)
            }
            else {
                self.ethereumView.backgroundColor = UIColor.init(red: ethColor, green: 0, blue: 0, alpha: 1)
            }
            
            
            let lastXCP: Float = Float((xcpTicker["last"]!)! as! String)!
            self.LastValueXCP.text = formatter.string(from: NSNumber(value: lastXCP))
            self.SavingsXCP.text = "$\(lastXCP * 175 * btcPrice)"
            let xcpPercentChange: Float = Float(xcpTicker["percentChange"] as! String)! * 100
            let xcpColor: CGFloat = sqrt(CGFloat(abs(xcpPercentChange/100.0)))
            if xcpPercentChange >= 0 {
                self.counterpartyView.backgroundColor = UIColor.init(red: 0, green: xcpColor, blue: 0, alpha: 1)
            }
            else {
                self.counterpartyView.backgroundColor = UIColor.init(red: xcpColor, green: 0, blue: 0, alpha: 1)
            }
            
            
            let lastDOGE: Float = Float((dogeTicker["last"]!)! as! String)!
            self.LastValueDOGE.text = formatter.string(from: NSNumber(value: lastDOGE))
            self.SavingsDOGE.text = "$\(lastDOGE * 473000 * btcPrice)"
            let dogePercentChange: Float = Float(dogeTicker["percentChange"] as! String)! * 100
            let dogeColor: CGFloat = sqrt(CGFloat(abs(dogePercentChange/100.0)))
            if dogePercentChange >= 0 {
                self.dogeView.backgroundColor = UIColor.init(red: 0, green: dogeColor, blue: 0, alpha: 1)
            }
            else {
                self.dogeView.backgroundColor = UIColor.init(red: dogeColor, green: 0, blue: 0, alpha: 1)
            }
        })
        
        //print(poloniexTicker)
    }
    
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        getTickerData()
    }

}

