//
//  BackEnabledNavigationController.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/24/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit

//Implements return back like the additional UINavBar swipe back one page
class BackEnabledNavigationController: UINavigationController, UIGestureRecognizerDelegate {
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.interactivePopGestureRecognizer?.delegate = self
  }
  
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return self.viewControllers.count > 1 
  }
  
  
  
}
