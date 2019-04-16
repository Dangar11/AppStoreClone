//
//  AppsController.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/15/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class AppsPageController: BaseListController {
  
  
  
  //MARK: - Properties
  fileprivate let cellId = "appId"
  fileprivate let headerId = "headerId"
  
  var editorsChoiceGames: AppGroup?
  
  var groups = [AppGroup]()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    //Register cell
    collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
    
    
    //Register header
    collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    
    fetchData() 
    
  }
  
  fileprivate func fetchData() {
    
    Service.shared.fetchGames { [unowned self] (appGroup, error) in
      
      if let error = error {
      print("Failed to fetch games", error)
        return
      }
      
      self.editorsChoiceGames = appGroup
      
      guard let appGroup = appGroup else { return }
      self.groups.append(appGroup)
      self.groups.append(appGroup)
      
      
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
      
    }
    
  }
  
  
  //MARK: - Header
  
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
    return header
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return .init(width: view.frame.width, height: 0)
  }
  
  
  
  
  //MARK: - Data Source
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return groups.count
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
    
    cell.titleLabel.text = editorsChoiceGames?.feed.title ?? ""
    cell.horizontalController.appGroup = editorsChoiceGames
    cell.horizontalController.collectionView.reloadData()
    
    return cell
  }
  
  
  
}



extension AppsPageController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: 300)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 16, left: 0, bottom: 0, right: 0)
  }
  
}
