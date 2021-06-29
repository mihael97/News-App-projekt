//
//  AppRouter.swift
//  news-app
//
//  Created by five on 29/06/2021.
//  Copyright © 2021 ios-vjestina. All rights reserved.
//

import Foundation
import UIKit

class AppRouter {
    private let navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func setScreen(window: UIWindow?) {
        let controller = InitialController()
        navigationController.pushViewController(controller, animated: true)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

extension AppRouter: AppRouterProtocol {
    
}
