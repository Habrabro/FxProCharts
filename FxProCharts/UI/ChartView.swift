//
//  ChartView.swift
//  FxProCharts
//
//  Created by admin on 28/01/2020.
//  Copyright © 2020 Anton Karpushko. All rights reserved.
//

import UIKit

class ChartView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var chartViewPeriodPicker: ChartPeriodPickerView!
    
    var data: [PeriodPickerCollectionViewCellModel] = [
        PeriodPickerCollectionViewCellModel(title: "1 M"),
        PeriodPickerCollectionViewCellModel(title: "1 M"),
        PeriodPickerCollectionViewCellModel(title: "1 M"),
        PeriodPickerCollectionViewCellModel(title: "1 M"),
        PeriodPickerCollectionViewCellModel(title: "1 M"),
        PeriodPickerCollectionViewCellModel(title: "1 M"),
    ]
    
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
        Bundle.main.loadNibNamed("ChartView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        chartViewPeriodPicker.configureWith(data: data)
    }
    
}
