//
//  AppsSearchController.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/14/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "Cell"

class AppsSearchController: UICollectionViewController {

  
  fileprivate let cellId = "searchCell"
  fileprivate var appResults = [Result]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
    
    
    fetchItunesApps()
    
  }
  
  
  
  fileprivate func fetchItunesApps()  {
    
    Service.shared.fetchApps { [unowned self] results, error  in
      if let error = error {
        print("Failed to fetch apps:", error)
        return
      }
      
      //get back our search results Success
      self.appResults = results
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
    
    
  }
  
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return appResults.count
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
    cell.appResult = appResults[indexPath.item]
    return cell
  }
  
  
  
  
  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  

}


extension AppsSearchController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: 350)
  }
  
}
