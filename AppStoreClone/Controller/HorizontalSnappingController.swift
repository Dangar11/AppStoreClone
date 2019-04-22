//
//  HorizontalSnappingController.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/17/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class HorizontalSnappingController: UICollectionViewController {
  
  init() {
    let layout = SnappingLayout()
    layout.scrollDirection = .horizontal
    super.init(collectionViewLayout: layout)
    collectionView.decelerationRate = .fast
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


class SnappingLayout: UICollectionViewFlowLayout {
  //snap behavior

  
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
    let parent = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
    //48 from AppsHorizontalController
    let itemWidth = collectionView.frame.width - 48
    
    let itemSpace = itemWidth + 10
    var pageNumber = round(collectionView.contentOffset.x / itemSpace)
    
    // Skip to the next cell, if there is residual scrolling velocity left.
    // This helps to prevent glitches
    let vX = velocity.x
    if vX > 0 {
      pageNumber += 1
    } else if vX < 0 {
      pageNumber -= 1
    }
    
    let nearestPageOffset = pageNumber * itemSpace
    return CGPoint(x: nearestPageOffset,
                   y: parent.y)
  }
  
}
