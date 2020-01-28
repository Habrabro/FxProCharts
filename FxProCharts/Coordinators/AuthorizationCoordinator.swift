//
//  AuthorizationCoordinator.swift
//  FxProNew
//
//  Created by admin on 22/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class AuthorizationCoordinator: Coordinator<UIViewController> {
    
    // MARK: Pages
    
    static let storyboard = UIStoryboard(name: "Authorization", bundle: nil)

    enum pages {
        case login
        case registration
        
        var viewController: UIViewController {
            switch self {
            case .login:
                let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                return viewController
            case .registration:
                let viewController = storyboard.instantiateViewController(withIdentifier: "RegistrationViewController")
                return viewController
            }
        }
    }
    
    // MARK: Lifecycle methods
    
    override func start(with completion: @escaping () -> Void = {}) {
        super.start()
        
        completion()
    }
    
}
