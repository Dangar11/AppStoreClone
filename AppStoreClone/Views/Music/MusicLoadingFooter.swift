//
//  MusicLoadingFooter.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/26/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class MusicLoadingFooter: UICollectionReusableView {
  
  
  
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    activityIndicator.color = .darkGray
    activityIndicator.startAnimating()

    let label = UILabel(text: "Loading more...", font: .systemFont(ofSize: 16))
    label.textAlignment = .center
    
    let stackView = VerticalStackView(arrangedSubviews: [
      activityIndicator, label
      ], spacing: 8)
    
    addSubview(stackView)
    stackView.centerInSuperview(size: .init(width: 200, height: 0))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
