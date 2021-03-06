//
//  AppsHorizontalController.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/15/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit

class AppsHorizontalController: HorizontalSnappingController {
  
  //MARK: - Properties
  
  fileprivate let cellId = "topCellId"
  
  var appGroup: AppGroup?
  
  var didSelectHadler: ((FeedResult) -> ())?
  
  let topBottomPadding: CGFloat = 12
  let lineSpacing: CGFloat = 10
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: cellId)
    
  }
  
  
  //MARK: - Data Source
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return appGroup?.feed.results.count ?? 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppRowCell
    let app = appGroup?.feed.results[indexPath.item]
    cell.companyLabel.text = app?.artistName
    cell.nameLabel.text = app?.name
    cell.imageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
    
    
    //Separator logic index starts from 0, add + 1 to make all 3-ird cell to show long separator, and for other cells shor separator
    if (indexPath.item + 1) % 3 == 0 {
      cell.separatorLine.isHidden = true
      cell.separatorLineForBottom.isHidden = false
    } else {
      cell.separatorLine.isHidden = false
      cell.separatorLineForBottom.isHidden = true
    }
  
    return cell
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let app = appGroup?.feed.results[indexPath.item]
    guard let appGroups = app else { return }
    didSelectHadler?(appGroups)
  }
  
  
}


extension AppsHorizontalController: UICollectionViewDelegateFlowLayout {
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //24 it's a top 12 and 12 bottom
    //20 is the 2 minumum linespacing between cells
    let height = (view.frame.height - 2 * topBottomPadding - lineSpacing * 2) / 3
    return .init(width: view.frame.width - 48, height: height)
  }
  
  
  //default minimum spacing = 10.0
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return lineSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: topBottomPadding, left: 16, bottom: topBottomPadding, right: 16)
  }
  
}
