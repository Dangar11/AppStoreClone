//
//  AppFullscreenCell.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/23/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class AppFullscreenCell: UITableViewCell {
  
  let todayCell = TodayCell()
  
  let descriptionLabel: UILabel = {
    let label = UILabel()
    
    let duration = 181
    
    let attributedText = NSMutableAttributedString(string: "Overview\n", attributes: [.foregroundColor: UIColor.black, .font : UIFont.systemFont(ofSize: 30, weight: .bold)])
    
    attributedText.append(NSMutableAttributedString(string: "After the devastating events of Avengers: Infinity War (2018), the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to undo Thanos' actions and restore order to the universe.", attributes: [.foregroundColor: UIColor.gray]))
    
    attributedText.append(NSMutableAttributedString(string: "\n\nDirectors: ", attributes: [.foregroundColor: UIColor.black]))
    attributedText.append(NSMutableAttributedString(string: "Anthony Russo, Joe Russo", attributes: [.foregroundColor: UIColor.gray]))
    
    attributedText.append(NSMutableAttributedString(string: "\nRelease Date: ", attributes: [.foregroundColor: UIColor.black]))
    attributedText.append(NSMutableAttributedString(string: "April 25", attributes: [.foregroundColor: UIColor.gray]))
    
    attributedText.append(NSMutableAttributedString(string: "\nGenres: ", attributes: [.foregroundColor: UIColor.black]))
    attributedText.append(NSMutableAttributedString(string: "Action | Adventure | Fantasy | Sci-Fi", attributes: [.foregroundColor: UIColor.gray]))
    
    attributedText.append(NSMutableAttributedString(string: "\nRuntime: ", attributes: [.foregroundColor: UIColor.black]))
    attributedText.append(NSMutableAttributedString(string: "\(duration) min | \(duration / 60) hrs \n\n\n\n", attributes: [.foregroundColor: UIColor.gray]))
    
    attributedText.append(NSMutableAttributedString(string: "After the devastating events of Avengers: Infinity War (2018), the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to undo Thanos' actions and restore order to the universe.", attributes: [.foregroundColor: UIColor.gray]))
    
    attributedText.append(NSMutableAttributedString(string: "\n\nDirectors: ", attributes: [.foregroundColor: UIColor.black]))
    attributedText.append(NSMutableAttributedString(string: "Anthony Russo, Joe Russo", attributes: [.foregroundColor: UIColor.gray]))
    
    attributedText.append(NSMutableAttributedString(string: "\nRelease Date: ", attributes: [.foregroundColor: UIColor.black]))
    attributedText.append(NSMutableAttributedString(string: "April 25", attributes: [.foregroundColor: UIColor.gray]))
    
    attributedText.append(NSMutableAttributedString(string: "\nGenres: ", attributes: [.foregroundColor: UIColor.black]))
    attributedText.append(NSMutableAttributedString(string: "Action | Adventure | Fantasy | Sci-Fi", attributes: [.foregroundColor: UIColor.gray]))
    
    attributedText.append(NSMutableAttributedString(string: "\nRuntime: ", attributes: [.foregroundColor: UIColor.black]))
    attributedText.append(NSMutableAttributedString(string: "\(duration) min | \(duration / 60) hrs ", attributes: [.foregroundColor: UIColor.gray]))
    
    label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    label.attributedText = attributedText
    label.numberOfLines = 0
    
    return label
  }()
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubview(descriptionLabel)
    descriptionLabel.fillSuperview(padding: .init(top: 24, left: 24, bottom: 0, right: 24))
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
