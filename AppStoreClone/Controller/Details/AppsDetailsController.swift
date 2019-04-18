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
      print("Here is AppId:", appId)
      let urlString = "https://itunes.apple.com/lookup?id=\(appId ?? "")"
      Service.shared.fetchGenericJSONData(urlString: urlString) { (result: SearchResult?, error) in
      }
    }
  }
  
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
    
    return cell
  }
  
}


extension AppsDetailsController: UICollectionViewDelegateFlowLayout {
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: 300)
  }
}
