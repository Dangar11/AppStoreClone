//
//  AppsHeaderCell.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/15/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit



class AppsHeaderCell: UICollectionViewCell {
  
  let companyLabel = UILabel(text: "Facebook", font: .boldSystemFont(ofSize: 12))
  let titleLabel = UILabel(text: "Keeping up with friends is faster than ever", font: .systemFont(ofSize: 24))
  
  let imageView = UIImageView(cornerRadius: 8)
  
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    companyLabel.textColor = UIColor(red:55/255.0, green:107/255.0, blue:194/255.0, alpha:1.0)
    titleLabel.numberOfLines = 0
    
    
    
    let stackView = VerticalStackView(arrangedSubviews: [
      companyLabel,
      titleLabel,
      imageView
      ], spacing: 6)
    imageView.heightAnchor.constraint(equalToConstant: 175).isActive = true
    imageView.contentMode = .scaleAspectFill
    imageView.layer.borderColor = UIColor.init(white: 0.5, alpha: 0.5).cgColor
    imageView.layer.borderWidth = 0.5
    addSubview(stackView)
    stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 16))
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}
