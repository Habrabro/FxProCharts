//
//  CollectionViewItemModel.swift
//  FxProNew
//
//  Created by admin on 15/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import CollectionAndTableViewCompatible

class PeriodPickerCollectionViewCellModel: CollectionViewCompatible {
    
    // MARK: Public properties
    
    var selected: Bool = false
    
    var reuseIdentifier: String {
        return "PeriodPickerCollectionViewCell"
    }
    
    var title: String
    var period: Periods
    
    // MARK: Init
    
    init(period: Periods) {
        self.period = period
        self.title = period.rawValue
    }
    
    // MARK: Public methods
    
    func cellForCollectionView(collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PeriodPickerCollectionViewCell
        cell.configure(withModel: self)
//        cell.setSize(to: collectionView.frame.size)
        
        return cell
    }
    
}
