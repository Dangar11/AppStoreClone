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
  
  let activityIndicatorView: UIActivityIndicatorView = {
    let activiyIndicator = UIActivityIndicatorView(style: .whiteLarge)
    activiyIndicator.color = UIColor(red:55/255.0, green:107/255.0, blue:194/255.0, alpha:1.0)
    activiyIndicator.startAnimating()
    activiyIndicator.hidesWhenStopped = true
    return activiyIndicator
  }()
  
  var editorsChoiceGames: AppGroup?
  
  var groups = [AppGroup]()
  
  var headerGroupApps = [ResultHeader]()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    //Register cell
    collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
    
    
    //Register header
    collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    
    //Activity indicator
    view.addSubview(activityIndicatorView)
    activityIndicatorView.fillSuperview()
    
    
    //Fetch data
    fetchData() 
    
  }
  
  //MARK: - Help Methods
  
  fileprivate func fetchData() {
    
    var group1: AppGroup?
    var group2: AppGroup?
    var group3: AppGroup?
    var group4: [ResultHeader]?
    
    //Sync data fetches together
    let dispatchGroup = DispatchGroup()
    dispatchGroup.enter()
    
    //Top Grossing
    Service.shared.fetchTopGrossing { (appGroup, error) in
      
      dispatchGroup.leave()
      group1 = appGroup
    }
    
    dispatchGroup.enter()
    //Fetch Games
    Service.shared.fetchGames { (appGroup, error) in
      
      dispatchGroup.leave()
      group2 = appGroup
      
    }
    
    dispatchGroup.enter()
    //Top paid
    Service.shared.fetchTopPaid { (appGroup, error) in
      
      dispatchGroup.leave()
      group3 = appGroup
      
    }
    
    dispatchGroup.enter()
    Service.shared.fetchSocialApps { (appsHeader, error) in
      
      dispatchGroup.leave()
      group4 = appsHeader?.results
      
      
    }
    
    //complition
    dispatchGroup.notify(queue: .main) {
      print("Completed dispatch group tasks")
      
      self.activityIndicatorView.stopAnimating()
      
      if let group = group1, let groupTwo = group2, let groupThree = group3, let groupFour = group4 {
        self.groups.append(group)
        self.groups.append(groupTwo)
        self.groups.append(groupThree)
        groupFour.forEach({ (group) in
          self.headerGroupApps.append(group)
        })
      }
      self.collectionView.reloadData()
    }
    
  }
  
  
  //MARK: - Header
  
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsPageHeader
    header.appHeaderHorizontalController.headerApp = headerGroupApps
    header.appHeaderHorizontalController.collectionView.reloadData()
    return header
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return .init(width: view.frame.width, height: 250)
  }
  
  
  
  
  //MARK: - Data Source
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return groups.count
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
    
    let appGroups = groups[indexPath.item]
    
    cell.titleLabel.text = appGroups.feed.title
    cell.horizontalController.appGroup = appGroups
    cell.horizontalController.collectionView.reloadData()
    cell.horizontalController.didSelectHadler = { [weak self] feedResult in
      
      let controller = AppsDetailsController(appId: feedResult.id)
      controller.navigationItem.title = feedResult.name
      self?.navigationController?.pushViewController(controller, animated: true)
    }
    
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
