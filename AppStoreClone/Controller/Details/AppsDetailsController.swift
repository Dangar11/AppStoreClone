//
//  AppsDetailsController.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/18/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class AppsDetailsController: BaseListController {
  
  let cellId = "cellId"
  
  var appId: String! {
    didSet {
      let urlString = "https://itunes.apple.com/lookup?id=\(appId ?? "")"
      Service.shared.fetchGenericJSONData(urlString: urlString) { (result: SearchResult?, error) in
        let app = result?.results.first
        self.app = app
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      }
    }
  }
  
  var app: ResultJSON?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    
    collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: cellId)
    navigationItem.largeTitleDisplayMode = .never
  }
  
  
  
  
  //MARK: - Data Source
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppDetailCell
    
    cell.app = app
    
    
    return cell
  }
  
}


extension AppsDetailsController: UICollectionViewDelegateFlowLayout {
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    // calculate the necessary size for our cell to fit the text
    let helperCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
    
    helperCell.app = app
    helperCell.layoutIfNeeded()
    
    let estimatedSize = helperCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
    
    
    
    return .init(width: view.frame.width, height: estimatedSize.height)
  }
}
