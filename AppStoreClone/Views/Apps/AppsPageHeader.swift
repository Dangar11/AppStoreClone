//
//  AppsPageHeader.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/15/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit



class AppsPageHeader: UICollectionReusableView {
  
  
  let appHeaderHorizontalController = AppsHeaderHorizontalController()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    
    addSubview(appHeaderHorizontalController.view)
    appHeaderHorizontalController.view.fillSuperview()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
