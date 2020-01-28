//
//  Extensions.swift
//  FxProNew
//
//  Created by admin on 22/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

extension UICollectionView {
    func reloadData(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() }) { _ in
            completion()
        }
    }
}
