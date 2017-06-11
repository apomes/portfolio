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
    var treemapModel: [NSDictionary]?
    
    // Model with the information of the assets
    var portfolio: Portfolio? = nil
    
    
    @IBOutlet weak var treemapView: TreemapView!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBAction func Close(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set transparency for the navigation bar
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = UIColor.clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // Reload treemap when device is about to rotate
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        UIView.beginAnimations("reload", context: nil)
        UIView.setAnimationDuration(0.25)
        treemapView.reloadData(size)
        UIView.commitAnimations()
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
            treemapModel = [NSDictionary]()
            
            // Sort assets by value size
            //portfolio?.sortByMethod(aSortMethod: SortMethod.Value)
            
            // Add assets to treemap model
            let assetCount:Int = (portfolio?.numberOfAssets())!
            for index in 0..<assetCount {
                let value: Float = portfolio!.getValueForAsset(index)
                let valueFormatted = portfolio!.getValueForAssetFormatted(index)
                let assetName = portfolio?.getNameForAsset(index)
                
                let assetInfo = NSDictionary(objects: [assetName!, value, valueFormatted], forKeys: (["name", "value", "valueFormatted"] as NSCopying) as! [NSCopying])
                treemapModel!.append(assetInfo)
            }
            
            // Sort by value stored in every asset
            treemapModel?.sort(by: {$0.value(forKey: "value") as! Float > $1.value(forKey: "value") as! Float})
        }
        
        var values = [Any]()
        for dict in treemapModel! {
            values.append((dict).value(forKey: "value") as! Float)
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
        cell.textLabel.text = (treemapModel![index]).value(forKey: "name") as! String?
        cell.valueLabel.text = (treemapModel![index]).value(forKey: "valueFormatted") as! String?
        
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
