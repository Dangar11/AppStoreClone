//
//  PreviewScreenshotsController.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/18/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class PreviewScreenshotsController : HorizontalSnappingController {
  
  
  let screenshotsCellId = "screenshotsCellId"
  
  var app: ResultJSON? {
    didSet {
      collectionView.reloadData()
      
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    collectionView.register(ScreenshotsCell.self, forCellWithReuseIdentifier: screenshotsCellId)
    
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return app?.screenshotUrls.count ?? 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenshotsCellId, for: indexPath) as! ScreenshotsCell
    let screenshotUrl = self.app?.screenshotUrls[indexPath.item]
    cell.imageView.sd_setImage(with: URL(string: screenshotUrl ?? ""))
    return cell
  }
  
}


extension PreviewScreenshotsController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: 250, height: view.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 16, left: 16, bottom: 16, right: 16)
  }
  
}
