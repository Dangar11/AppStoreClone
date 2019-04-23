//
//  HeaderView.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/23/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class HeaderView: UICollectionReusableView {
  
  
  let todayLabel: UILabel = {
    let label = UILabel(text: "Today", font: .boldSystemFont(ofSize: 40))
    return label
  }()
  
  let dateLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    return label
  }()
  
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(dateLabel)
    addSubview(todayLabel)
    dateLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 32, left: 32, bottom: 0, right: 0))
    todayLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 32, bottom: 0, right: 0))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}
