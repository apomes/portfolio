//
//  UIAssetsScrollView.swift
//  Portfolio
//
//  Created by Ausias on 13/03/16.
//  Copyright © 2016 kobiuter. All rights reserved.
//

import UIKit

class UIAssetsScrollView: UIScrollView, UIScrollViewDelegate {
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("did end dragging")
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("didScroll")
    }
    
}

// Delegate protocol
protocol UIAssetsScrollViewDelegate {
    func updateData()
    
}