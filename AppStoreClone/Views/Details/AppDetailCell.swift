//
//  AppDetailCell.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/18/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit

class AppDetailCell: UICollectionViewCell {
  
  var app: ResultJSON! {
    didSet {
     nameLabel.text = app?.trackName
     releaseNotesLabel.text = app?.releaseNotes
     appIconImageView.sd_setImage(with: URL(string: app?.artworkUrl512 ?? ""))
     priceButton.setTitle(app?.formattedPrice, for: .normal)
    }
  }
  

  
  let appIconImageView = UIImageView(cornerRadius: 16)
  
  let nameLabel = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
  
  let priceButton = UIButton(title: "$4.99")
  
  let whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 20))
  
  let releaseNotesLabel = UILabel(text: "Release Notes", font: .systemFont(ofSize: 18), numberOfLines: 0)
  
  let separatorLine : UIView = {
    let separator = UIView(frame: .zero)
    separator.backgroundColor = UIColor.lightGray
    return separator
  }()
  
  
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
    
    separatorLine.widthAnchor.constraint(equalToConstant: frame.width)
    separatorLine.heightAnchor.constraint(equalToConstant: 1.0)
    
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
    addSubview(separatorLine)
    mainStackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    separatorLine.anchor(top: mainStackView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 19, left: 20, bottom: 0, right: 20))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}
