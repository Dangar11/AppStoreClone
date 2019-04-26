//
//  TodayMultipleAppCell.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/24/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit

class TodayMultipleAppCell: BaseTodayCell {
  
  var todayItem: TodayItem! {
    didSet {
      categoryLabel.text = todayItem.releaseDate
      titleLabel.text = todayItem.title
      
      multipleAppController.apps = todayItem.apps
      multipleAppController.collectionView.reloadData()
    }
  }
  
  let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
  let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 32), numberOfLines: 0)
  
  let multipleAppController = TodayMultipleAppsController(mode: .small)
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  
    backgroundColor = .white
    layer.cornerRadius = 16
    
    let stackView = VerticalStackView(arrangedSubviews: [
      categoryLabel,
      titleLabel,
      multipleAppController.view
      ], spacing: 16)
    
    addSubview(stackView)
    stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
