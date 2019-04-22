//
//  ReviewsController.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/18/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit

class ReviewsController: HorizontalSnappingController {
  
  let cellId = "cellId"
  
  var reviews: Reviews? {
    didSet {
      self.collectionView.reloadData()
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: cellId)
    collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    
  }
  
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return reviews?.feed.entry.count ?? 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ReviewCell
    let entry = self.reviews?.feed.entry[indexPath.item]
    cell.titleLabel.text = entry?.title.label
    cell.authorLabel.text = entry?.author.name.label
    cell.bodyLabel.text = entry?.content.label
    
    //Get the index inside of starsStackView and compare with rating from API
    //Set the alpha value comparing 2 values to 1 or 0 
    for (index, view) in cell.starsStackView.arrangedSubviews.enumerated() {
      if let rating = Int(entry?.rating.label ?? "0") {
        view.alpha = index >= rating ? 0 : 1
      }
    }
    
    
    
    return cell
  }
  
}

extension ReviewsController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    print(view.frame.height)
    return .init(width: view.frame.width - 48, height: view.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 16
  }
}
