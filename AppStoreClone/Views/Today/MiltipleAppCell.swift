//
//  MiltipleAppCell.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/24/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit

class MultipleAppCell: UICollectionViewCell {
  
  
  var app: FeedResult! {
    didSet {
      nameLabel.text = app.name
      compamyLabel.text = app.artistName
      imageView.sd_setImage(with: URL(string: app.artworkUrl100))
    }
  }
  
  let imageView = UIImageView(cornerRadius: 8)
  
  let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20))
  
  let compamyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
  
  let getButton = UIButton(title: "GET")
  
  let separatorLine : UIView = {
    let separator = UIView()
    separator.backgroundColor = UIColor.lightGray
    return separator
  }()
  
  
  let separatorLineForBottom: UIView = {
    let separator = UIView(frame: .zero)
    separator.backgroundColor = UIColor.lightGray
    return separator
  }()
  
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    
    imageView.backgroundColor = .purple
    imageView.constrainWidth(constant: 64)
    imageView.constrainHeight(constant: 64)
    
    separatorLineForBottom.widthAnchor.constraint(equalToConstant: frame.width)
    separatorLineForBottom.heightAnchor.constraint(equalToConstant: 1.0)
    separatorLineForBottom.isHidden = true
    
    getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
    getButton.constrainWidth(constant: 80)
    getButton.constrainHeight(constant: 32)
    getButton.layer.cornerRadius = 32 / 2
    getButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
    getButton.tintColor = UIColor(red:55/255.0, green:107/255.0, blue:194/255.0, alpha:1.0)
    
    let verticalStackView = VerticalStackView(arrangedSubviews: [
      nameLabel, compamyLabel
      ], spacing: 4)
    
    
    let stackView = UIStackView(arrangedSubviews: [
      imageView, verticalStackView, getButton
      ])
    stackView.spacing = 16
    
    stackView.alignment = .center
    addSubview(stackView)
    addSubview(separatorLine)
    stackView.fillSuperview()
    separatorLine.anchor(top: nil, leading: nameLabel.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: -4, right: 0), size: .init(width: 0, height: 0.5))
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
