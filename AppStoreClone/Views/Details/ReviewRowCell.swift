//
//  ReviewRowCell.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/18/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class ReviewRowCell: UICollectionViewCell {
  
  let reviewsController = ReviewsController()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .yellow
    
    
    addSubview(reviewsController.view)
    reviewsController.view.fillSuperview()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
