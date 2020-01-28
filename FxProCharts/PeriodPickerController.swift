//
//  PeriodPickerController.swift
//  FxProCharts
//
//  Created by admin on 28/01/2020.
//  Copyright © 2020 Anton Karpushko. All rights reserved.
//

import UIKit

class PeriodPickerController {
    
    var view: UIView
    
    init(with view: UIView) {
        self.view = view
        
        
    }
    
    func expand(animated: Bool = false) {
        view.frame.size.width = 150
    }
    
    @objc private func didTapped() {
        expand()
    }
    
}
