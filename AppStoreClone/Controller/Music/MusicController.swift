//
//  MusicController.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/26/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class MusicController: BaseListController {
  
  
  
  fileprivate let cellId = "cellId"
  fileprivate let footerId = "footerId"
  
  fileprivate let searchTerm = "Queen"
  
  var isPaginating = false
  
  var isDonePagination = false
  var results = [ResultJSON]() //empty array for population data
  
  //MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    collectionView.register(TrackCell.self, forCellWithReuseIdentifier: cellId)
    collectionView.register(MusicLoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
    
    
    fetchData(pagination: 0)
    
  }
  
  
  fileprivate func fetchData(pagination: Int) {
    
    let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=\(pagination)&limit=20"
    Service.shared.fetchGenericJSONData(urlString: urlString) { (searchResult: SearchResult?, error) in
      if let error = error {
        print("Failed to paginate data: ", error)
      }
      
      sleep(2)
      
      if searchResult?.results.count == 0 {
        self.isDonePagination = true
      }
      self.results += searchResult?.results ?? []
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
      self.isPaginating = false
    }
    
  }
  
  
  //MARK: - DATA SOURCE
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return results.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TrackCell
    
    let track = results[indexPath.item]
    
    cell.nameLabel.text = track.trackName
    cell.imageView.sd_setImage(with: URL(string: track.artworkUrl100))
    cell.subtitleLabel.text = "\(track.artistName ?? "") • \(track.collectionName ?? "")"
    
    //initiate pagination
    if indexPath.item == results.count - 1 && !isPaginating {
      isPaginating = true
      fetchData(pagination: results.count)
    }
    
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
    return footer
  }
  
  
  
  
}




extension MusicController : UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: 100)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    let height: CGFloat = isDonePagination ? 0 : 100
    return .init(width: view.frame.width, height: height)
  }
  
}
