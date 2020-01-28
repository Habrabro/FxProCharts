//
//  CornerRadiusCustomizable.swift
//  FxProNew
//
//  Created by admin on 14/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

protocol CornerRadiusCustomizable where Self: UIView {
    
    func roundCorners(radius: CGFloat)
    
}

extension CornerRadiusCustomizable {
    
    func roundCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
}
