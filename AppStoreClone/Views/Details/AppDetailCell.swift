//
//  AppDetailCell.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/18/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit

class AppDetailCell: UICollectionViewCell {
  
  let appIconImageView = UIImageView(cornerRadius: 16)
  
  let nameLabel = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
  
  let priceButton = UIButton(title: "$4.99")
  
  let whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 20))
  
  let releaseNotesLabel = UILabel(text: "Release Notes", font: .systemFont(ofSize: 16), numberOfLines: 0)
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    appIconImageView.backgroundColor = .red
    appIconImageView.constrainWidth(constant: 140)
    appIconImageView.constrainHeight(constant: 140)
    priceButton.backgroundColor = UIColor(red:55/255.0, green:107/255.0, blue:194/255.0, alpha:1.0)
    priceButton.constrainHeight(constant: 32)
    priceButton.constrainWidth(constant: 80)
    priceButton.layer.cornerRadius = 32 / 2
    priceButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
    priceButton.setTitleColor(.white, for: .normal)
    
    //To cut the button size
    let buttonStackView = UIStackView(arrangedSubviews: [priceButton, UIView()])
    
    
    let verticalStackView = VerticalStackView(arrangedSubviews: [
      nameLabel, buttonStackView
      ]
      , spacing: 12)
    
    
    let horizontalStackView = UIStackView(arrangedSubviews: [
      appIconImageView, verticalStackView
      ])
    horizontalStackView.spacing = 16
    
    let mainStackView = VerticalStackView(arrangedSubviews:
      [horizontalStackView,
       whatsNewLabel,
       releaseNotesLabel], spacing: 16)
    addSubview(mainStackView)
    mainStackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}
