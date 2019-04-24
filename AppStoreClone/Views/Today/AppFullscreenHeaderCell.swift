//
//  AppFullscreenHeaderCell.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/23/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class AppFullscreenHeaderCell: UITableViewCell {
  
  let todayCell = TodayCell()
  
  let closeButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "close").withRenderingMode(.alwaysOriginal), for: .normal)
    return button
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubview(todayCell)
    todayCell.fillSuperview()
    
    addSubview(closeButton)
    closeButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 36, left: 0, bottom: 0, right: 12), size: .init(width: 38, height: 38))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
}

