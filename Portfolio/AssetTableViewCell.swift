//
//  AssetTableViewCell.swift
//  Portfolio
//
//  Created by Ausias on 30/03/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import UIKit

class AssetTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backgroundView?.backgroundColor = UIColor.grayColor()
        print("cell")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
