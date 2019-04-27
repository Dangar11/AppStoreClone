//
//  TrackCell.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/26/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit

class TrackCell: UICollectionViewCell {
  
  
  let imageView = UIImageView(cornerRadius: 16)
  let nameLabel = UILabel(text: "Track Name", font: .boldSystemFont(ofSize: 18))
  let subtitleLabel = UILabel(text: "Subtitle", font: .systemFont(ofSize: 16), numberOfLines: 2)
  let separator = UIView(frame: .zero)
  let imageViewSeparator = UIImageView(cornerRadius: 0)
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    imageView.image = #imageLiteral(resourceName: "wick3")
    imageView.constrainWidth(constant: 70)
    imageView.constrainHeight(constant: 90)
    
    
    
    imageViewSeparator.image = #imageLiteral(resourceName: "line")
    
    
    
    let verticalStack = VerticalStackView(arrangedSubviews: [nameLabel, subtitleLabel], spacing: 4)
    
    let stackView = UIStackView(arrangedSubviews: [
      imageView, verticalStack
      ])
    stackView.spacing = 16
    addSubview(stackView)
    addSubview(separator)
    separator.addSubview(imageViewSeparator)
    imageViewSeparator.fillSuperview()
    
    stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    separator.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 50, bottom: 2, right: 16), size: .init(width: frame.width, height: 10))
    stackView.alignment = .center
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
  
}
