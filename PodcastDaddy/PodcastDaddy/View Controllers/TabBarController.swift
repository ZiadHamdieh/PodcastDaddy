//
//  TabBarController.swift
//  PodcastDaddy
//
//  Created by Ziad Hamdieh on 2019-03-24.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .purple
        view.backgroundColor = .white
        
        viewControllers = [
            generateNavigationController(for: UIViewController(), title: "Favourites", image: #imageLiteral(resourceName: "favorites")),
            generateNavigationController(for: UIViewController(), title: "Search", image: #imageLiteral(resourceName: "search")),
            generateNavigationController(for: UIViewController(), title: "Downloads", image: #imageLiteral(resourceName: "downloads"))
        ]
    }
    
    fileprivate func generateNavigationController(for viewController: UIViewController, title: String, image: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        viewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
    
}
