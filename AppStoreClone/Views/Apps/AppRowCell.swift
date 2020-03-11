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
    
  let getButton : UIButton = {
    let btn = UIButton(type: .system)
    btn.setImage(#imageLiteral(resourceName: "download"), for: .normal)
    btn.tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    return btn
  }()
  
  let separatorLine : UIView = {
    let separator = UIView(frame: .zero)
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
    
    
    imageView.backgroundColor = .white
    imageView.constrainWidth(constant: 64)
    imageView.constrainHeight(constant: 64)
    
    separatorLine.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
    separatorLine.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
    
    separatorLineForBottom.isHidden = true
    
    getButton.constrainWidth(constant: 40)
    getButton.constrainHeight(constant: 40)
    
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
    addSubview(separatorLineForBottom)
    stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
    separatorLine.anchor(top: stackView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 9, left: 64, bottom: 0, right: 0))
    separatorLineForBottom.anchor(top: stackView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 9, left: 0, bottom: 0, right: 0))
    
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}
