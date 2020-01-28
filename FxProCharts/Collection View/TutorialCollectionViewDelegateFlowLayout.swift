//
//  CollectionViewDelegateFlowLayout.swift
//  FxProNew
//
//  Created by admin on 15/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class TutorialCollectionViewDelegateFlowLayout: NSObject, UICollectionViewDelegateFlowLayout {
    
    static let DEFAULT_CELL_SIZE = CGSize(width: 50, height: 50)
    
    var cellSize: CGSize
    
    init(cellSize: CGSize = DEFAULT_CELL_SIZE) {
        self.cellSize = cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let cell = collectionView.cellForItem(at: indexPath)
            return next
    }
}
