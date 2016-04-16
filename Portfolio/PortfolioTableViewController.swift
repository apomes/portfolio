//
//  PortfolioTableViewController.swift
//  Portfolio
//
//  Created by Ausias on 02/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import UIKit

class PortfolioTableViewController: UITableViewController, PortfolioDelegate {
    
    // Constants
    
    /** Height for every row in the table. */
    let rowHeight : CGFloat = 80.0
    
    var delegate: PortfolioViewController?
    
    /** Model for the portfolio asset list. */
    var portfolio = Portfolio()
    
    
    
    @IBAction func UIAddNewAssetButton(sender: AnyObject) {
        performSegueWithIdentifier("DisplayAssetView", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        portfolio.delegate = self
        
        // Add items to portfolio model (just testing)
        // TODO: This should be added through UI (PLUS button in table)
        portfolio.addAsset("Bitcoin", quantity: 1.0)
        portfolio.addAsset("Ethereum", quantity: 1.0)
        portfolio.addAsset("Factom", quantity: 1.0)
        portfolio.addAsset("Counterparty", quantity: 174.0)
        portfolio.addAsset("Dogecoin", quantity: 2500)
        portfolio.addAsset("Dash", quantity: 101)
        portfolio.addAsset("Litecoin", quantity: 236)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    // MARK: - Table view update methods
    
    /** Refresh portfolio data. */
    func refresh() {
        portfolio.refresh()
    }
    
    
    
    /** Returns the total value in the portfolio. */
    func getPortfolioTotalValue() -> Float {
        return portfolio.getTotalValue()
    }
    
    
    
    //  o-o     O  o-O-o   O       o-o   o-o  o   o o--o    o-o o--o
    //  |  \   / \   |    / \     |     o   o |   | |   |  /    |
    //  |   O o---o  |   o---o     o-o  |   | |   | O-Oo  O     O-o
    //  |  /  |   |  |   |   |        | o   o |   | |  \   \    |
    //  o-o   o   o  o   o   o    o--o   o-o   o-o  o   o   o-o o--o
    //
    //

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return portfolio.numberOfAssets() + 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row < portfolio.numberOfAssets() {
            let cell = tableView.dequeueReusableCellWithIdentifier("AssetCellID", forIndexPath: indexPath) as! PortfolioTableViewCell

            // Configure the cell...
            cell.assetName.text = portfolio.getNameForAsset(indexPath.row)
            cell.assetPrice.text = portfolio.getPriceForAssetFormatted(indexPath.row)
            cell.setSubtractiveBgColorForPercentChange(portfolio.getPercentChangeForAsset(indexPath.row))
//            cell.setPriceLabelColorForPercentChange(portfolio.getPercentChangeForAsset(indexPath.row))
            
            return cell
        }
        else {
            // Last cell in the table, to add a new asset
            let cell = tableView.dequeueReusableCellWithIdentifier("AddAssetCellID", forIndexPath: indexPath)
            
            return cell
        }
        
    }
    
    
    
    //  o-o   o--o o    o--o  o-o    O  o-O-o o--o
    //  |  \  |    |    |    o      / \   |   |
    //  |   O O-o  |    O-o  |  -o o---o  |   O-o
    //  |  /  |    |    |    o   | |   |  |   |
    //  o-o   o--o O---oo--o  o-o  o   o  o   o--o
    //
    //
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return rowHeight
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    // MARK: - Delegate methods for portfolio model
    
    func portfolioDidUpdateData(portfolio: Portfolio) {
        // Reload table after portfolio pulled fresh data
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            
            // Notify delegate that the portfolio got updated
            self.delegate?.portfolioTableDidUpdate(self)
        })
    }
    
}



//  o--o  o--o   o-o  o-O-o  o-o    o-o  o-o  o     o-o
//  |   | |   | o   o   |   o   o  /    o   o |    |
//  O--o  O-Oo  |   |   |   |   | O     |   | |     o-o
//  |     |  \  o   o   |   o   o  \    o   o |        |
//  o     o   o  o-o    o    o-o    o-o  o-o  O---oo--o
//
// MARK: - Delegate methods for the Portfolio Table View Controller
protocol PortfolioTableViewControllerDelegate {
    func portfolioTableDidTapOnAsset(portfolioTableViewController: PortfolioTableViewController,
        assetIndex index: Int)
    
    func portfolioTableDidUpdate(portfolioTableViewController: PortfolioTableViewController)
}
