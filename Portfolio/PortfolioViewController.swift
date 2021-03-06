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
    
    /** Controller that contains the table view with all the assets */
    var portfolioTableViewController: PortfolioTableViewController?
    
    /** Controller for the lock screen for privacy reasons. */
    var lockScreenViewController: LockScreenViewController?
    
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
    
    @IBOutlet weak var SortPortfolioButton: UIBarButtonItem!
    @IBAction func sortPortfolio(_ sender: Any) {
        // Sort portfolio table 
        portfolioTableViewController?.sort()
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
        
        // Present privacy screen and request authentication
        lockScreenViewController = (myStoryboard.instantiateViewController(withIdentifier: "LockScreenID") as! LockScreenViewController)
        lockScreenViewController!.modalPresentationStyle = .overFullScreen
        
        self.parent?.present(lockScreenViewController!, animated: false, completion:
            {() -> Void in
                // Init portfolio once the privace screen finished appearing
                self.portfolioTableViewController?.initPortfolio()
                self.portfolioTableViewController?.sortByMethod(aSortMethod: SortMethod.Percent)
        })
        lockScreenViewController!.isLocked = true
        lockScreenViewController!.requestLocalAuthentication()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func addNewChildViewController(_ viewController:UIViewController, parentView:UIView) {
        // Add controller to the controllers hierarchy
        // This also calls willMoveToParentViewController
        self.addChild(viewController)
        
        // Add controller's view to parent's view hierarchy
        parentView.addSubview(viewController.view)
        
        // Notify controller it was added to parent controller hierarchy
        viewController.didMove(toParent: self)
        
    }
    
    
    
    /** Manage controller view size changes including rotations. */
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Manage rotation
        print("View is about to rotate!")
        
        // TODO: Implement changes on UI for rotation. For instance, in portrait mode we show symbols of currencies while in landscape we show the full name.
        
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "TreemapView") {
            //if you need to pass data to the next controller do it here
            // Get the new view controller using segue.destinationViewController.
            let treemapViewController: TreemapViewController = segue.destination as! TreemapViewController
            
            // Pass the selected object to the new view controller.
            treemapViewController.portfolio = portfolioTableViewController?.portfolio
        }
    }
 
    
    
    /** Updates the label of the portfolio button. */
    func ChangeSortButtonLabelToMethod(aSortMethod: SortMethod) {
        var sortButtonSymbol: String
        
        switch aSortMethod {
        case SortMethod.Name:
            sortButtonSymbol = "@"
        case SortMethod.Price:
            sortButtonSymbol = "$"
        case SortMethod.Quantity:
            sortButtonSymbol = "Q"
        case SortMethod.Value:
            sortButtonSymbol = "V"
        case SortMethod.Percent:
            sortButtonSymbol = "%"
        }
        
        // Update sort button symbol
        SortPortfolioButton.title = sortButtonSymbol
    }
    
    
    
    // MARK: - Data persistence methods
    
    func savePortfolioData() {
        portfolioTableViewController?.savePortfolioData()
    }
    
    
    
    
    //  o-o   o--o o    o--o  o-o    O  o-O-o o--o
    //  |  \  |    |    |    o      / \   |   |
    //  |   O O-o  |    O-o  |  -o o---o  |   O-o
    //  |  /  |    |    |    o   | |   |  |   |
    //  o-o   o--o O---oo--o  o-o  o   o  o   o--o
    //
    
    // MARK: - Delegate methods for the Portfolio Table View Controller
    
    func portfolioTableDidTapOnAsset(_ portfolioTableViewController: PortfolioTableViewController, assetIndex index: Int) {
        print("Method portfolioTableDidTapOnAsset NOT implemented yet...")
        
    }
    
    func portfolioTableDidUpdate(_ portfolioTableViewController: PortfolioTableViewController) {
        TotalValue.text = CurrencyFormatter.sharedInstance.string(from: NSNumber(value: portfolioTableViewController.getPortfolioTotalValue()))
    }
    
    func portfolioTableShouldUseLocalCurrency(_ portfolioTableViewController: PortfolioTableViewController) -> Bool {
        return _shouldUseLocalCurrency
    }
    
    func portfolioTableDidChangeSortMethod(_ portfolioTableViewController: PortfolioTableViewController, sortMethod aSortMethod: SortMethod) {
        ChangeSortButtonLabelToMethod(aSortMethod: aSortMethod)
    }

}
