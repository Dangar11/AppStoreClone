//
//  TodayCell.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/23/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class TodayCell: BaseTodayCell {
  
  var todayItem: TodayItem! {
    didSet {
      imageView.image = todayItem.image
      
    }
    
  }
  
  
  let imageView = UIImageView(image: #imageLiteral(resourceName: "men-in-black"))
  let imageContainerView = UIView()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    layer.cornerRadius = 16
    backgroundColor = .white
  
    imageContainerView.clipsToBounds = true
    imageContainerView.layer.cornerRadius = 16
    imageContainerView.addSubview(imageView)
    
    imageView.fillSuperview()
    
    addSubview(imageContainerView)
    imageContainerView.fillSuperview()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}
