//
//  AppsDetailsController.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/18/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class AppsDetailsController: BaseListController {
  
  let cellId = "detailCellId"
  let previewCellId = "previewCellId"
  let reviewCellId = "reviewCellId"
  
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
      
      let reviewsUrl = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId ?? "")/sortby=mostrecent/json?l=en&cc=us"
      
      Service.shared.fetchGenericJSONData(urlString: reviewsUrl) { (reviews: Reviews?, error) in
        
        if let error = error {
          print(error)
        }
        
        self.reviews = reviews
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
        
//        reviews?.feed.entry.forEach({ (entry) in
//          print(entry.title.label, entry.author.name.label, entry.content.label)
//        })
        
      }
    }
  }
  
  var app: ResultJSON?
  var reviews: Reviews?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    
    collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: cellId)
    collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: previewCellId)
    collectionView.register(ReviewRowCell.self, forCellWithReuseIdentifier: reviewCellId)
    navigationItem.largeTitleDisplayMode = .never
  }
  
  
  
  
  //MARK: - Data Source
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    
    switch indexPath.item {
    case 0:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppDetailCell
      cell.app = app
      return cell
    case 1:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! PreviewCell
      cell.horizontalController.app = self.app
      return cell
    case 2:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as! ReviewRowCell
      cell.reviewsController.reviews = self.reviews
      return cell
    default:
      return UICollectionViewCell()
    }
    
    
  }
  
}


extension AppsDetailsController: UICollectionViewDelegateFlowLayout {
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    var height: CGFloat = 280
    
    switch indexPath.item {
    case 0:
      // calculate the necessary size for our cell to fit the text
      let helperCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
      
      helperCell.app = app
      helperCell.layoutIfNeeded()
      
      let estimatedSize = helperCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
      
      height = estimatedSize.height
    case 1:
      height = 500
    case 2:
      height = 250
    default:
      height = 250
    }
    
    return .init(width: view.frame.width, height: height)
 
  }
}
