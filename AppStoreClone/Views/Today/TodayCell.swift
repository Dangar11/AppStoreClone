//
//  TodayCell.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/23/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class TodayCell: UICollectionViewCell {
  

  let imageView = UIImageView(image: UIImage(named: "avengers"))
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
    layer.cornerRadius = 16
    
    addSubview(imageView)
    imageView.contentMode = .scaleAspectFill
    imageView.centerInSuperview(size: .init(width: 250, height: 250))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}
