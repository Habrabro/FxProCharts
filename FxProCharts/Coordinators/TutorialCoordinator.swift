//
//  TutorialCoordinator.swift
//  FxProNew
//
//  Created by admin on 14/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class TutorialCoordinator: Coordinator<UIViewController> {
    
    static let storyboard = UIStoryboard(name: "Tutorial", bundle: nil)
    
    enum pages {
        case defaultPage
        
        var viewController: UIViewController {
            switch self {
            case .defaultPage:
                let viewController = storyboard.instantiateViewController(withIdentifier: "TutorialViewController")
                return viewController
            }
        }
    }
    
    override func start(with completion: @escaping () -> Void = {}) {
        super.start()
        
        completion()
    }
    
    
    
}
