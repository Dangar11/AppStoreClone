//
//  TodayMultipleAppsController.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/24/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class TodayMultipleAppsController: BaseListController {
  
  
  let cellId = "cellId"
  
  var results = [FeedResult]()
  
  fileprivate let spacing: CGFloat = 16
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    
    collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: cellId)
    collectionView.isScrollEnabled = false
    
    
    Service.shared.fetchGames { (appGroup, error) in
      if let error = error {
        print(error)
      }
      
      self.results = appGroup?.feed.results ?? []
      
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return min(3, results.count)
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MultipleAppCell
    cell.app = results[indexPath.item]
    return cell
  }
  
  
  
  
}

extension TodayMultipleAppsController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let height: CGFloat = (view.frame.height - 3 * spacing) / 3
    
    return .init(width: view.frame.width, height: height)
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return spacing
  }
  
}
