//
//  PeriodPicker.swift
//  FxProCharts
//
//  Created by admin on 28/01/2020.
//  Copyright © 2020 Anton Karpushko. All rights reserved.
//

import UIKit

class ChartPeriodPickerView: UIView, CornerRadiusCustomizable {
    
    // MARK: Constants
    
    let CORNER_RADIUS: CGFloat = 4
    
    // MARK: Public properties
    
    @IBOutlet var contentView: UIView!
    var data: [PeriodPickerCollectionViewCellModel]?
    private var periodPickerCollectionViewController: PeriodPickerCollectionViewController!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var periodPickerTrailingConstraint: NSLayoutConstraint!
    
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
        
        Bundle.main.loadNibNamed("ChartPeriodPickerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func configureWith(data: [PeriodPickerCollectionViewCellModel]) {
        self.data = data
        
        periodPickerCollectionViewController = PeriodPickerCollectionViewController(collectionView: collectionView, data: data)
    }
    
}
