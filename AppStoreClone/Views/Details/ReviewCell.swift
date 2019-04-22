//
//  ReviewCell.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/18/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class ReviewCell: UICollectionViewCell {
  
  
  let titleLabel = UILabel(text: "Review Tittle", font: .boldSystemFont(ofSize: 18))
  
  let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16))
  
  let bodyLabel = UILabel(text: "Review body\nReview body\nReview body\nReview body\n", font: .systemFont(ofSize: 16), numberOfLines: 0)
  
  let starsStackView : UIStackView = {
    var arrangedSubviews = [UIView]()
    (0..<5).forEach({ (_) in
      let imageView = UIImageView(image: UIImage(named: "star"))
      imageView.constrainWidth(constant: 36)
      imageView.constrainHeight(constant: 36)
      arrangedSubviews.append(imageView)
    })
    
    arrangedSubviews.append(UIView())
    
    let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
    return stackView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor(white: 0.9, alpha: 0.5)
    layer.cornerRadius = 16
    clipsToBounds = true
    
    let topStackView = UIStackView(arrangedSubviews: [
      titleLabel, UIView(), authorLabel
      ])
    
    let stackView = VerticalStackView(arrangedSubviews: [
      topStackView,
      starsStackView,
      bodyLabel, UIView()
      ], spacing: 16)
    //give the priority to resist cut
    titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
    
    
    
    addSubview(stackView)
    stackView.fillSuperview(padding: .init(top: 12, left: 12, bottom: 12, right: 12))
    
    
  }
  
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}
