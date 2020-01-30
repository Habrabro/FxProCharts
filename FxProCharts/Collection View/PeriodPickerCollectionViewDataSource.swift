//
//  CollectionViewDataSource.swift
//  FxProNew
//
//  Created by admin on 15/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import CollectionAndTableViewCompatible

class PeriodPickerCollectionViewDataSource: CollectionViewDataSource {
    
    let CELL_NIB_NAME = "PeriodPickerCollectionViewCell"
    
    var data: [CollectionViewCompatible]
    
    init(data: [CollectionViewCompatible] = [], collectionView: UICollectionView) {
        self.data = data
        super.init(collectionView: collectionView)
        prepareData()
    }
    
    func prepareData() {
        let section = CollectionViewSection(sortOrder: 0, items: data)
        sections = [section].sorted {
            return $0.sortOrder < $1.sortOrder
        }
        if let reuseIdentifier = data.first?.reuseIdentifier {
            collectionView.register(UINib(nibName: CELL_NIB_NAME, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        }
    }
    
}
