//
//  PortfolioTableViewCell.swift
//  Portfolio
//
//  Created by Ausias on 07/04/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import UIKit

class PortfolioTableViewCell: UITableViewCell {

    @IBOutlet weak var assetName: UILabel!
    @IBOutlet weak var assetPrice: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func setBackgroundColorForPercentChange(percentChange: Float) {
        let intensity: CGFloat = sqrt(CGFloat(abs(percentChange/100.0)))
        if percentChange >= 0 {
            self.backgroundColor = UIColor.init(red: 0, green: intensity, blue: 0, alpha: 1)
        }
        else {
            self.backgroundColor = UIColor.init(red: intensity, green: 0, blue: 0, alpha: 1)
        }
    }

}
