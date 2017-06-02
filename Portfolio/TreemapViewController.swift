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
        
        var dict = [NSDictionary]()
        let dic = NSDictionary(object: 23, forKey: "Doge" as NSCopying)
        dict.append(dic)
        
        return dict
    }
    
    
    func treemapView(_ treemapView: TreemapView!, cellFor index: Int, for rect: CGRect) -> TreemapViewCell! {
        // TODO: implement this...
        
        return nil
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
