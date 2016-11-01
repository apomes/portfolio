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
    
    /** True if the portfolio should use the local currency to display value. */
    var _shouldUseLocalCurrency: Bool = false
    
    
    
    // VIEW
    @IBOutlet weak var TotalValue: UILabel!
    

    @IBAction func tapOnTotalValue(_ sender: UITapGestureRecognizer) {
        _shouldUseLocalCurrency = !_shouldUseLocalCurrency
        
        portfolioTableViewController?.refresh()
        
    }
    
    @IBAction func refreshPortfolio(_ sender: AnyObject) {
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
        portfolioTableViewController = (myStoryboard.instantiateViewController(withIdentifier: "PortfolioTableControllerID") as! PortfolioTableViewController)
        
        // Present portfolio table view controller and handle view hierarchy
        addNewChildViewController(portfolioTableViewController!, parentView: self.view)
        
        // Position portfolio table within the main portfolio controller view
        portfolioTableViewController?.view.frame = CGRect(x: 0, y: portfolioHeaderHeight, width: self.view.frame.width, height: self.view.frame.height - portfolioHeaderHeight)
        
        // Add self as delegate for the portfolio table view controller
        portfolioTableViewController?.delegate = self
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addNewChildViewController(_ viewController:UIViewController, parentView:UIView) {
        // Add controller to the controllers hierarchy
        // This also calls willMoveToParentViewController
        self.addChildViewController(viewController)
        
        // Add controller's view to parent's view hierarchy
        parentView.addSubview(viewController.view)
        
        // Notify controller it was added to parent controller hierarchy
        viewController.didMove(toParentViewController: self)
        
    }
    
    
    
    /** Manage controller view size changes including rotations. */
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Manage rotation
        print("View is about to rotate!")
        
        // TODO: Implement changes on UI for rotation. For instance, in portrait mode we show symbols of currencies while in landscape we show the full name.
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    //  o-o   o--o o    o--o  o-o    O  o-O-o o--o
    //  |  \  |    |    |    o      / \   |   |
    //  |   O O-o  |    O-o  |  -o o---o  |   O-o
    //  |  /  |    |    |    o   | |   |  |   |
    //  o-o   o--o O---oo--o  o-o  o   o  o   o--o
    //
    
    // MARK: - Delegate methods for the Portfolio Table View Controller
    
    func portfolioTableDidTapOnAsset(_ portfolioTableViewController: PortfolioTableViewController, assetIndex index: Int) {
        print("Implement portfolioTableDidTapOnAsset method...")
    }
    
    func portfolioTableDidUpdate(_ portfolioTableViewController: PortfolioTableViewController) {
        print("update total...")
        
        TotalValue.text = CurrencyFormatter.sharedInstance.string(from: NSNumber(value: portfolioTableViewController.getPortfolioTotalValue()))
    }
    
    func portfolioTableShouldUseLocalCurrency(_ portfolioTableViewController: PortfolioTableViewController) -> Bool {
        return _shouldUseLocalCurrency
    }

}
