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
    var coins: NSMutableArray?
    
    
    
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
        if (coins == nil) {
            // Init coins
            coins = NSMutableArray()
            coins!.add(NSDictionary(object: 23, forKey: "Doge" as NSCopying))
            coins!.add(NSDictionary(object: 54, forKey: "Augur" as NSCopying))
        }
        
        var values = [Any]()
        for dict in coins! {
            values.append((dict as! NSDictionary).allValues.first as! Int)
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
//        NSNumber *val = [[fruits objectAtIndex:index] valueForKey:@"value"];
//        cell.textLabel.text = [[fruits objectAtIndex:index] valueForKey:@"name"];
//        cell.valueLabel.text = [val stringValue];
//        cell.backgroundColor = [UIColor colorWithHue:(float)index / (fruits.count + 3)
//        saturation:1 brightness:0.75 alpha:1];
        
        let val = (coins?.object(at: index) as! NSDictionary).allValues.first as! Int
        cell.textLabel.text = (coins?.object(at: index) as! NSDictionary).allKeys.first as! String?
        cell.valueLabel.text = String(val)
        if (index == 0) {
            cell.backgroundColor = UIColor.blue
        }
        if (index == 1) {
            cell.backgroundColor = UIColor.orange
        }
        
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
