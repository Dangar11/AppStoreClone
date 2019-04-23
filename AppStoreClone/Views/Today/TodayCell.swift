//
//  TodayCell.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/23/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class TodayCell: UICollectionViewCell {
  
  var todayItem: TodayItem! {
    didSet {
      imageView.image = todayItem.image
    }
    
  }
  

  let imageView = UIImageView(image: #imageLiteral(resourceName: "men-in-black"))
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
    layer.cornerRadius = 16
    clipsToBounds = true
    
    addSubview(imageView)
    imageView.contentMode = .scaleAspectFill
    imageView.fillSuperview()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}
