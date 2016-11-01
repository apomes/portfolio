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
    let rowHeight : CGFloat = 90.0
    
    var delegate: PortfolioViewController?
    
    /** Model for the portfolio asset list. */
    var portfolio = Portfolio()
    
    
    
    @IBAction func UIAddNewAssetButton(_ sender: AnyObject) {
        performSegue(withIdentifier: "DisplayAssetView", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        portfolio.delegate = self
        
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return portfolio.numberOfAssets() + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath as NSIndexPath).row < portfolio.numberOfAssets() {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AssetCellID", for: indexPath) as! PortfolioTableViewCell

            // Configure the cell...
            cell.assetName.text = portfolio.getNameForAsset((indexPath as NSIndexPath).row)
            cell.assetPrice.text = portfolio.getPriceForAssetFormatted((indexPath as NSIndexPath).row)
            
            if (delegate?.portfolioTableShouldUseLocalCurrency(self)) == true {
                cell.assetQuantity.text = portfolio.getValueForAssetFormatted((indexPath as NSIndexPath).row)
            }
            else {
                cell.assetQuantity.text = portfolio.getQuantityForAssetFormatted((indexPath as NSIndexPath).row)
            }
            
            // Set cell background color
            cell.setSubtractiveBgColorForPercentChange(portfolio.getPercentChangeForAsset((indexPath as NSIndexPath).row))
//            cell.setPriceLabelColorForPercentChange(portfolio.getPercentChangeForAsset(indexPath.row))
            
            return cell
        }
        else {
            // Last cell in the table, to add a new asset
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddAssetCellID", for: indexPath)
            
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {

    }
 

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    // MARK: - Delegate methods for portfolio model
    
    func portfolioDidUpdateData(_ portfolio: Portfolio) {
        // Reload table after portfolio pulled fresh data
        DispatchQueue.main.async(execute: {
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
    func portfolioTableDidTapOnAsset(_ portfolioTableViewController: PortfolioTableViewController,
        assetIndex index: Int)
    
    func portfolioTableDidUpdate(_ portfolioTableViewController: PortfolioTableViewController)
    
    func portfolioTableShouldUseLocalCurrency(_ portfolioTableViewController: PortfolioTableViewController) -> Bool
}
