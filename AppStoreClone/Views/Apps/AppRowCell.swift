//
//  AppRowCell.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/15/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit



class AppRowCell: UICollectionViewCell {
  
  
  let imageView = UIImageView(cornerRadius: 8)
  
  let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20))
  
  let compamyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
    
  let getButton = UIButton(title: "GET")
  
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    
    imageView.backgroundColor = .purple
    imageView.constrainWidth(constant: 64)
    imageView.constrainHeight(constant: 64)
    
    getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
    getButton.constrainWidth(constant: 80)
    getButton.constrainHeight(constant: 32)
    getButton.layer.cornerRadius = 32 / 2
    getButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
    
    let verticalStackView = VerticalStackView(arrangedSubviews: [
      nameLabel, compamyLabel
      ], spacing: 4)
    
    
    let stackView = UIStackView(arrangedSubviews: [
      imageView, verticalStackView, getButton
      ])
    stackView.spacing = 16
    
    stackView.alignment = .center
    addSubview(stackView)
    stackView.fillSuperview()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}
