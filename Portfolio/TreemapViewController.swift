//
//  TreemapViewController.swift
//  Portfolio
//
//  Created by Ausias on 31/03/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import UIKit

class TreemapViewController: UIViewController,
TreemapViewDelegate, TreemapViewDataSource {

    
    
    // Our inventory of coins
    var treemapModel: NSMutableArray?
    
    // Model with the information of the assets
    var portfolio: Portfolio? = nil
    
    
    
    @IBAction func Close(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    //  o-o     O  o-O-o   O       o-o   o-o  o   o o--o    o-o o--o
    //  |  \   / \   |    / \     |     o   o |   | |   |  /    |
    //  |   O o---o  |   o---o     o-o  |   | |   | O-Oo  O     O-o
    //  |  /  |   |  |   |   |        | o   o |   | |  \   \    |
    //  o-o   o   o  o   o   o    o--o   o-o   o-o  o   o   o-o o--o
    //
    //
    // MARK: - Treemap data source
    func values(for treemapView: TreemapView!) -> [Any]! {
        // TODO: implement this...
        if (portfolio != nil) {
            // Init model
            treemapModel = NSMutableArray()
            
            // Sort assets by value size
            portfolio?.sortByMethod(aSortMethod: SortMethod.Value)
            
            // Add assets to treemap model
            let assetCount:Int = (portfolio?.numberOfAssets())!
            for index in 0..<assetCount {
                let value = portfolio?.getValueForAsset(index)
                let assetName = portfolio?.getNameForAsset(index)
                treemapModel!.add(NSDictionary(object: value! as Float, forKey: assetName! as NSCopying))
            }
        }
        
        var values = [Any]()
        for dict in treemapModel! {
            values.append((dict as! NSDictionary).allValues.first as! Float)
        }
        
        return values
    }
    
    
    
    /**
     Creates a new treemap cell view for a specific index.
 
     - parameter index: the index of the cell to be created.
     - parameter rect: the rect that defines the frame of the cell.
 
     - returns: The treemap cell view initialized.
    */
    func treemapView(_ treemapView: TreemapView!, cellFor index: Int, for rect: CGRect) -> TreemapViewCell! {
        let cell = TreemapViewCell(frame: rect)
        updateCellView(cell: cell!, forindex: index)
        return cell
    }
    
    
    /**
     Updates a treemap cell view.
     
     - parameter cell: the treemap view cell to update.
     - parameter index: the index of the cell we want to update.
     */
    func updateCellView(cell: TreemapViewCell, forindex index: NSInteger) {
        cell.textLabel.text = (treemapModel?.object(at: index) as! NSDictionary).allKeys.first as! String?
        cell.valueLabel.text = portfolio?.getValueForAssetFormatted(index)
        
        // Pick colors from blue color palette for now
        cell.backgroundColor = UIColor(hue: 0.55, saturation: 1, brightness: CGFloat(1)/CGFloat(index + 1), alpha: 1)
        
    }
    
    
    
    //  o-o   o--o o    o--o  o-o    O  o-O-o o--o  o-o
    //  |  \  |    |    |    o      / \   |   |    |
    //  |   O O-o  |    O-o  |  -o o---o  |   O-o   o-o
    //  |  /  |    |    |    o   | |   |  |   |        |
    //  o-o   o--o O---oo--o  o-o  o   o  o   o--o o--o
    //
    //
    // MARK: - Treemap delegate
    
    
    

}
