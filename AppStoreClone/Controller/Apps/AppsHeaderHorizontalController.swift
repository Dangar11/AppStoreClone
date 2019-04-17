//
//  AppsHeaderHorizontalController.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/15/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class AppsHeaderHorizontalController : HorizontalSnappingController {
  
  
  fileprivate let cellId = "cellId"
  
  var headerApp = [ResultHeader]()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    
    collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: cellId)
    
    
    
    
  }
  
  
  
  func fetchData() {
    
    
  }
  
  
  
  //MARK: - Data Source
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return headerApp.count
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsHeaderCell
    let app = self.headerApp[indexPath.item]
    cell.companyLabel.text = app.artistName
    cell.titleLabel .text = String(app.description.prefix(37))
    cell.imageView.sd_setImage(with: URL(string: app.artworkUrl512))
    return cell
  }
  
  
}


//MARK: - Size of the cell


extension AppsHeaderHorizontalController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width - 48, height: view.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 0, left: 16, bottom: 0, right: 16)
  }
  
  
}
