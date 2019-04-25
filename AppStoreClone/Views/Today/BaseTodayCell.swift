//
//  BaseTodayCell.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/24/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class BaseTodayCell: UICollectionViewCell {
  
  
  override var isHighlighted: Bool {
    didSet {
      
      var transform: CGAffineTransform = .identity
      if isHighlighted {
        transform = .init(scaleX: 0.9, y: 0.9)
      }
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
        self.transform = transform
      })
    }
  }
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    //This resterize layer for better perfomance issue
    self.backgroundView = UIView()
    addSubview(self.backgroundView!)
    self.backgroundView?.fillSuperview()
    self.backgroundView?.backgroundColor = .white
    self.backgroundView?.layer.cornerRadius = 16
    
    self.backgroundView?.layer.shadowOpacity = 0.2
    self.backgroundView?.layer.shadowRadius = 10
    self.backgroundView?.layer.shadowOffset = .init(width: 0, height: 10)
    self.backgroundView?.layer.shouldRasterize = true
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}
