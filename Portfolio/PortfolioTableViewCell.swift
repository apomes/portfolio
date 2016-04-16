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
    
    
    
    /** Changes the cell background color to visualize the change in value
     of the asset with colors based on an additive color model. */
    func setAdditiveBgColorForPercentChange(percentChange: Float) {
        let intensity: CGFloat = sqrt(CGFloat(abs(percentChange/100.0)))
        if percentChange >= 0 {
            self.backgroundColor = UIColor.init(red: 0, green: intensity, blue: 0, alpha: 1)
        }
        else {
            self.backgroundColor = UIColor.init(red: intensity, green: 0, blue: 0, alpha: 1)
        }
    }
    
    
    
    /** Changes the cell background color to visualize the change in value
     of the asset with colors based on a substractive color model. */
    func setSubtractiveBgColorForPercentChange(percentChange: Float) {
        let intensity: CGFloat = sqrt(CGFloat(abs(percentChange/100.0)))
        if percentChange >= 0 {
            self.backgroundColor = UIColor.init(red: 0, green: 1, blue: 0, alpha: intensity)
        }
        else {
            self.backgroundColor = UIColor.init(red: 1, green: 0, blue: 0, alpha: intensity)
        }
    }
    
    
    
    /** Changes the price text label color to visualize the change in value
     of the asset. */
    func setPriceLabelColorForPercentChange(percentChange: Float) {
        let intensity: CGFloat = sqrt(CGFloat(abs(percentChange/100.0)))
        if percentChange >= 0 {
            self.assetPrice.textColor = UIColor.init(red: 0, green: intensity, blue: 0, alpha: 1)
        }
        else {
            self.assetPrice.textColor = UIColor.init(red: intensity, green: 0, blue: 0, alpha: 1)
        }
    }

}
