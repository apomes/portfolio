//
//  PortfolioTableViewController.swift
//  Portfolio
//
//  Created by Ausias on 02/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import UIKit

class PortfolioTableViewController: UITableViewController, PortfolioDelegate, UINewAssetViewControllerDelegate {
    
    // Constants
    
    /** Height for every row in the table. */
    let rowHeight : CGFloat = 90.0
    
    var delegate: PortfolioViewController?
    
    /** Model for the portfolio asset list. */
    var portfolio = Portfolio()
    
    
    
    @IBAction func UIAddNewAssetButton(_ sender: AnyObject) {
        performSegue(withIdentifier: "AddNewAsset", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        portfolio.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Reload table to make sure data is up to date
        reloadTable()
    }
    
    
    func initPortfolio() {
        portfolio.initPortfolio()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    // MARK: - Table view callback methods
    
    /** Refresh portfolio data. */
    func refresh() {
        portfolio.refresh()
    }
    
    
    
    /** Sort portfolio assets. */
    func sort() {
        // TODO: for now we just cycle sort methods with one single button.
        // UI should allow users to choose the sort method.
        portfolio.sortCycle()
    }
    
    func sortByMethod(aSortMethod: SortMethod) {
        portfolio.sortByMethod(aSortMethod: aSortMethod)
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
    
    
    
    //  o-o   o--o o    o--o  o-o    O  o-O-o o--o  o-o
    //  |  \  |    |    |    o      / \   |   |    |
    //  |   O O-o  |    O-o  |  -o o---o  |   O-o   o-o
    //  |  /  |    |    |    o   | |   |  |   |        |
    //  o-o   o--o O---oo--o  o-o  o   o  o   o--o o--o
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Update portfolio model to delete row from the data source
            portfolio.removeAsset(index: indexPath.row)
            
            // Commit changes to the portfolio view
            tableView.deleteRows(at: [indexPath], with: .left)
            
            // Update total sum of assets
            delegate?.portfolioTableDidUpdate(self)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            //TODO: ...
            
            
            // Reload portfolio to update total count of assets
            reloadTable()
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
    
    
    
    // MARK: - New asset view controller delegate
    
    func newAssetViewController(_ newAssetViewController: UINewAssetViewController, didReturnNewAssetWithName assetName: String, quantity: Float) {
        portfolio.addAsset(assetName, quantity: quantity)
    }
    
    
 

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Make sure your segue name in storyboard is the same as this line
        if (segue.identifier == "DisplayAssetDetail") {
            //if you need to pass data to the next controller do it here
            // Get the new view controller using segue.destinationViewController.
            let detailViewController: AssetDetailViewController = segue.destination as! AssetDetailViewController
            
            // Pass the selected object to the new view controller.
            detailViewController.asset = sender as? Asset
        }
        if (segue.identifier == "AddNewAsset") {
            let newAssetViewController: UINewAssetViewController =
                segue.destination as! UINewAssetViewController
            newAssetViewController.delegate = self
        }
        
    }
    
    
    
    // MARK: - Selection 
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Launch segue with asset model
        performSegue(withIdentifier: "DisplayAssetDetail",
                     sender: portfolio.getAssetAtIndex(indexPath.row))
    }
    

    
    
    // MARK: - Delegate methods for portfolio model
    
    func portfolioDidUpdateData(_ portfolio: Portfolio) {
        reloadTable()
    }
    
    func portfolioDidChangeSortMethod(_ portfolio: Portfolio, sortMethod aSortMethod: SortMethod) {
        DispatchQueue.main.async(execute: {
            self.delegate?.portfolioTableDidChangeSortMethod(self, sortMethod: aSortMethod)
        })
    }
    
    
    
    // MARK: - Helper methods
    
    func reloadTable() {
        // Reload table after portfolio pulled fresh data
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
            
            // Notify delegate that the portfolio got updated
            self.delegate?.portfolioTableDidUpdate(self)
        })
    }
    
    
    
    // MARK: - Persistence methods
    
    func savePortfolioData() {
        portfolio.savePortfolioData()
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
    
    func portfolioTableDidChangeSortMethod(_ portfolioTableViewController: PortfolioTableViewController, sortMethod aSortMethod: SortMethod)
}
