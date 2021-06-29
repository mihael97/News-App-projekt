//
//  TabBarController.swift
//  news-app
//
//  Created by five on 29/06/2021.
//  Copyright © 2021 ios-vjestina. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    private var router: AppRouterProtocol!
    
    convenience init(router: AppRouterProtocol) {
        self.init()
        self.router = router
        setFooter()
    }
    
    public func setFooter() {
        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)

        let initialController = InitialController()
        initialController.tabBarItem = UITabBarItem(title: "Home", image: nil, selectedImage: nil)
        let newsStoryController = NewsStoryViewController()
        newsStoryController.tabBarItem = UITabBarItem(title: "News", image: nil, selectedImage: nil)
        self.viewControllers = [initialController, newsStoryController]
    }
}
