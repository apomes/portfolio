//
//  PortfolioViewController.swift
//  Portfolio
//
//  Created by Ausias on 02/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import UIKit

class PortfolioViewController: UIViewController, PortfolioTableViewControllerDelegate {

    
    
    // OTHER CONTROLLERS
    var portfolioTableViewController: PortfolioTableViewController?
    
    
    
    // MODEL
    /** Height of the portfolio header. */
    let portfolioHeaderHeight: CGFloat = 100.0
    
    /** Model for the portfolio header. */
    // FIXME: this model may not be necessary for now...
    var portfolioHeader = PortfolioHeader()
    
    
    
    // VIEW
    @IBOutlet weak var TotalValue: UILabel!
    
    @IBAction func refreshPortfolio(sender: AnyObject) {
        // Update portfolio table model and view
        portfolioTableViewController?.refresh()
    }
    
    
    
    //  o   o o--o o-O-o o  o  o-o  o-o    o-o
    //  |\ /| |      |   |  | o   o |  \  |
    //  | O | O-o    |   O--O |   | |   O  o-o
    //  |   | |      |   |  | o   o |  /      |
    //  o   o o--o   o   o  o  o-o  o-o   o--o
    //
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        /************ VIEWS ****************/
        // Add portfolio table view controller as child
        let myStoryboard:UIStoryboard = self.storyboard!
        portfolioTableViewController = (myStoryboard.instantiateViewControllerWithIdentifier("PortfolioTableControllerID") as! PortfolioTableViewController)
        
        // Present portfolio table view controller and handle view hierarchy
        addNewChildViewController(portfolioTableViewController!, parentView: self.view)
        
        // Position portfolio table within the main portfolio controller view
        portfolioTableViewController?.view.frame = CGRectMake(0, portfolioHeaderHeight, self.view.frame.width, self.view.frame.height - portfolioHeaderHeight)
        
        // Add self as delegate for the portfolio table view controller
        portfolioTableViewController?.delegate = self
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addNewChildViewController(viewController:UIViewController, parentView:UIView) {
        // Add controller to the controllers hierarchy
        // This also calls willMoveToParentViewController
        self.addChildViewController(viewController)
        
        // Add controller's view to parent's view hierarchy
        parentView.addSubview(viewController.view)
        
        // Notify controller it was added to parent controller hierarchy
        viewController.didMoveToParentViewController(self)
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    // MARK: - Delegate methods for the Portfolio Table View Controller
    
    func portfolioTableDidTapOnAsset(portfolioTableViewController: PortfolioTableViewController, assetIndex index: Int) {
        print("Implement portfolioTableDidTapOnAsset method...")
    }
    
    func portfolioTableDidUpdate(portfolioTableViewController: PortfolioTableViewController) {
        print("update total...")
        
        TotalValue.text = CurrencyFormatter.sharedInstance.stringFromNumber((portfolioTableViewController.getPortfolioTotalValue()))
    }

}
