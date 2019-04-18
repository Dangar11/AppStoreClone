//
//  ScreenshotsCell.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/18/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class ScreenshotsCell: UICollectionViewCell {
  
  let imageView = UIImageView(cornerRadius: 12)
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    imageView.backgroundColor = .blue
    addSubview(imageView)
    imageView.fillSuperview()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}




