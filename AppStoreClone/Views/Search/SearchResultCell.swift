//
//  SearchResultCell.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/14/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
  
  
  var appResult: ResultJSON! {
    didSet {
      
      nameLabel.text = appResult.trackName
      categoryLabel.text = appResult.primaryGenreName
      ratingsLabel.text = "Rating: \(appResult.averageUserRating ?? 0)"
      
      let url = URL(string: appResult.artworkUrl100)
      appIconImageView.sd_setImage(with: url)
      
      screenshot1ImageView.sd_setImage(with:
        URL(string: appResult.screenshotUrls![0]))
      if appResult.screenshotUrls!.count > 1 {
        screenshot2ImageView.sd_setImage(with:
          URL(string: appResult.screenshotUrls![1]))
      }
      
      if appResult.screenshotUrls!.count > 2 {
        screenshot3ImageView.sd_setImage(with:
          URL(string: appResult.screenshotUrls![2]))
      }
    }
  }
  
  let appIconImageView: UIImageView =  {
    let iv = UIImageView()
    iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
    iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
    iv.layer.cornerRadius = 12
    iv.clipsToBounds = true
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
  
  
  
  let getButton : UIButton = {
    let btn = UIButton(type: .system)
    btn.setImage(#imageLiteral(resourceName: "download"), for: .normal)
    btn.tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    return btn
  }()
  
  lazy var screenshot1ImageView = self.createScreenshotImageView()
  lazy var screenshot2ImageView = self.createScreenshotImageView()
  lazy var screenshot3ImageView = self.createScreenshotImageView()
  
  func createScreenshotImageView() -> UIImageView {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 8
    imageView.clipsToBounds = true
    imageView.layer.borderWidth = 0.5
    imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
    imageView.contentMode = .scaleAspectFill
    return imageView
  }
  
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    getButton.constrainWidth(constant: 40)
    getButton.constrainHeight(constant: 40)
    
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
