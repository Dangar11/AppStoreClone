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
  fileprivate let searchController = UISearchController(searchResultsController: nil)
  
  fileprivate var appResults = [Result]()
  
  fileprivate let enterSearchTermLabel: UILabel = {
    let label = UILabel()
    label.text = "Please enter search term above..."
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 20)
    return label
  }()
  
  var timer: Timer?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
    
    collectionView.addSubview(enterSearchTermLabel)
    enterSearchTermLabel.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: 50))
    enterSearchTermLabel.layer.opacity = 0
    
    
    setupSearchBar()
    
    animateSearchLabel(opacity: 1)
    
  }
  
  
  fileprivate func setupSearchBar() {
    definesPresentationContext = true
    navigationItem.searchController = self.searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    searchController.dimsBackgroundDuringPresentation = false
    searchController.searchBar.delegate = self
  }
  
  
  func animateSearchLabel(opacity: Float) {
    UIView.animate(withDuration: 0.6) {
      self.enterSearchTermLabel.layer.opacity = opacity
    }
  }
  
  
  
  fileprivate func fetchItunesApps()  {
    
    Service.shared.fetchApps(searchTerm: "") { [unowned self] results, error  in
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


extension AppsSearchController: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    
    //delay before performing the search
    //throttling the search
    
    if searchText.isEmpty {
      animateSearchLabel(opacity: 1)
    } else {
      animateSearchLabel(opacity: 0)
    }
    
    
    
    timer?.invalidate()
    
    timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
      
      //fire the search
      Service.shared.fetchApps(searchTerm: searchText) { (result, error) in
        self.appResults = result
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      }
      
    })
    
    
    
  }
  
}
