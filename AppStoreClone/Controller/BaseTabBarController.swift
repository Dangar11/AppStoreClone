//
//  BaseTabBarController.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/14/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class BaseTabBarController: UITabBarController {
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewControllers = [
      createNavController(viewController: AppsController(), title: "Apps", imageName: "apps"),
      createNavController(viewController: SearchController(), title: "Search", imageName: "search"),
      createNavController(viewController: UIViewController(), title: "Today", imageName: "today_icon"),
    ]
    
    
  }
  
  
  
  fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
    
    viewController.view.backgroundColor = .white
    viewController.navigationItem.title = title
    
    
    let navController = UINavigationController(rootViewController: viewController)
    navController.tabBarItem.title = title
    navController.tabBarItem.image = UIImage(named: imageName)
    navController.navigationBar.prefersLargeTitles = true
    
    return navController
    
  }
  
}
