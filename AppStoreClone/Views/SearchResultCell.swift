//
//  SearchResultCell.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/14/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
  
  let appIconImageView: UIImageView =  {
    let iv = UIImageView()
    iv.backgroundColor = .red
    iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
    iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
    iv.layer.cornerRadius = 12
    return iv
    
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "APP NAME"
    return label
  }()
  
  let categoryLabel: UILabel = {
    let label = UILabel()
    label.text = "Photos & Video"
    return label
  }()
  
  let ratingsLabel: UILabel = {
    let label = UILabel()
    label.text = "9.27M"
    return label
  }()
  
  
  
  let getButton: UIButton = {
    let btn = UIButton(type: .system)
    btn.setTitle("GET", for: .normal)
    btn.setTitleColor(.blue, for: .normal)
    btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
    btn.backgroundColor = .lightGray
    btn.layer.cornerRadius = 12
    btn.widthAnchor.constraint(equalToConstant: 80).isActive = true
    return btn
  }()
  
  lazy var screenshot1ImageView = self.createScreenshotImageView()
  lazy var screenshot2ImageView = self.createScreenshotImageView()
  lazy var screenshot3ImageView = self.createScreenshotImageView()
  
  func createScreenshotImageView() -> UIImageView {
    let imageView = UIImageView()
    imageView.backgroundColor = .blue
    return imageView
  }
  
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    
    
    // optional
    
    let labelStackView = VerticalStackView(arrangedSubviews: [
      nameLabel, categoryLabel, ratingsLabel
      ])
    
    let topInfoStackView = UIStackView(arrangedSubviews: [
      appIconImageView, labelStackView, getButton
      ])
    topInfoStackView.spacing = 12
    topInfoStackView.alignment = .center
    
    let bottomScreenshotsStackView = UIStackView(arrangedSubviews: [
      screenshot1ImageView, screenshot2ImageView, screenshot3ImageView
      ])
    bottomScreenshotsStackView.distribution = .fillEqually
    bottomScreenshotsStackView.spacing = 12
    
    
    let overallStackView = VerticalStackView(arrangedSubviews: [
      topInfoStackView, bottomScreenshotsStackView
      ], spacing: 16)
    
    addSubview(overallStackView)
    overallStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}
