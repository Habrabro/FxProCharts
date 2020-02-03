//
//  TutorialCollectionViewCell.swift
//  FxProNew
//
//  Created by admin on 16/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import CollectionAndTableViewCompatible

class PeriodPickerCollectionViewCell: UICollectionViewCell, Configurable {

    // MARK: Constants
    
    static let DEFAULT_CELL_SIZE = CGSize(width: 40, height: 40)
    static let CELL_PADDING_HORIZONTAL = CGFloat(20)
    
    // MARK: Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: Public properties
    
    var cellSize: CGSize = DEFAULT_CELL_SIZE
    var model: PeriodPickerCollectionViewCellModel?
    
    // MARK: Lifecycle methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Actions
    
    // MARK: Public methods
    
    func configure(withModel model: PeriodPickerCollectionViewCellModel) {
        self.model = model
        
        titleLabel.text = model.title
        titleLabel.layoutIfNeeded()
        cellSize.width = titleLabel.frame.size.width + PeriodPickerCollectionViewCell.CELL_PADDING_HORIZONTAL
    }
    
    func setSize(to size: CGSize) {
        cellSize = size
    }

}
