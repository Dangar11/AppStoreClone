//
//  SearchResultCell.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/14/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
  
  let imageView: UIImageView =  {
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
  
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .yellow
    
    let labelStackView = UIStackView(arrangedSubviews: [
      nameLabel, categoryLabel, ratingsLabel])
    labelStackView.axis = .vertical
    
    let stackView = UIStackView(arrangedSubviews: [
      imageView, labelStackView, getButton
      ])
    stackView.spacing = 12
    stackView.alignment = .center
    
    addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
    stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
    stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}
