//
//  PeriodPickerContainer.swift
//  FxProCharts
//
//  Created by admin on 30/01/2020.
//  Copyright © 2020 Anton Karpushko. All rights reserved.
//

import UIKit

class PeriodPickerContainer: UIView, CornerRadiusCustomizable {
    
    // MARK: Constants
    
    let CORNER_RADIUS = CGFloat(4)
    
    // MARK: Initializers
    
    override init(frame aFrame: CGRect) {
        super.init(frame: aFrame)
    
        commonInit()
    }
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        
        commonInit()
    }
    
    func commonInit() {
        roundCorners(radius: CORNER_RADIUS)
    }
}
