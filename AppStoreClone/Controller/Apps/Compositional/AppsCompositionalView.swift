//
//  AppsCompositionalView.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 11.03.2020.
//  Copyright © 2020 Igor Tkach. All rights reserved.
//

import SwiftUI


class CompositionalHeader: UICollectionReusableView {
  
  let label = UILabel(text: "Editor's Games", font: .boldSystemFont(ofSize: 32))
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(label)
    label.fillSuperview()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

enum AppSection {
  case topSocial
  case games
  case topGrossing
  case topPaid
}


class CompositionalController: UICollectionViewController {
  
  //MARK: - Properties
  
  var socialApps = [ResultHeader]()
  var games: AppGroup?
  var topGrossingApps: AppGroup?
  var topPaid: AppGroup?
  
  
  lazy var diffableDataSource: UICollectionViewDiffableDataSource<AppSection, AnyHashable> = .init(collectionView: self.collectionView) { [ weak self] (collectionView, indexPath, object) -> UICollectionViewCell? in
    guard let self = self else { return nil}
    
    if let object = object as? ResultHeader {
      let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: self.topCellId, for: indexPath) as! AppsHeaderCell
      cell.app = object
      return cell
    } else if let object = object as? FeedResult {
      let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: self.centerCellid, for: indexPath) as! AppRowCell
      cell.app = object
      
      cell.getButton.addTarget(self, action: #selector(self.handleGet), for: .primaryActionTriggered)
      return cell
    }
    
    return nil
  }
  
  
  let topCellId = "topCellId"
  let centerCellid = "centerCellId"
  let headerId = "headerId"
  
  
  //MARK: - VC LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .systemBackground
    navigationItem.title = "Apps"
    navigationController?.navigationBar.prefersLargeTitles = true
    collectionView.register(CompositionalHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: topCellId)
    collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: centerCellid)
    
    navigationItem.rightBarButtonItem = .init(title: "Fetch Top Paid", style: .plain, target: self, action: #selector(handleFetchTopPaid))
    navigationItem.rightBarButtonItem?.tintColor = UIColor.label
    
    collectionView.refreshControl = UIRefreshControl()
    collectionView.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    
//    fetchAppsDispatchGroup()
    setupDiffableDatasourse()
  }
  
  
  
  //MARK: - Class Init
  init() {
    
    let layout = UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
      
      switch sectionNumber {
      case 0:
        return CompositionalController.firstSection()
      case 1:
        return CompositionalController.secondSection()
        
      default:
        return CompositionalController.secondSection()
      }
      
      
    }
    
    super.init(collectionViewLayout: layout)
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
  
  //MARK: - Helper Methods
  static func firstSection() -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
    item.contentInsets.bottom = 16
    item.contentInsets.trailing = 16
    
    
    let group = NSCollectionLayoutGroup.horizontal(layoutSize:
      .init(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(300)), subitems: [item])
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .groupPaging
    section.contentInsets.leading = 16
    return section
  }
  
  
  static func secondSection() -> NSCollectionLayoutSection {
    
    let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)))
    item.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 16)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(300))
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .groupPaging
    section.contentInsets.leading = 16
    //MARK: HEADER RENDER
    let kind = UICollectionView.elementKindSectionHeader
    section.boundarySupplementaryItems = [
      .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: kind, alignment: .topLeading)]
    
    return section
  }
  
  
  //MARK: - @OBJC
  @objc func handleGet(button: UIView) {
    
    var superview = button.superview
    
    // reach the parent cell of get button
    while superview != nil {
      if let cell = superview as? UICollectionViewCell {
        guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
        guard let objectClickled = diffableDataSource.itemIdentifier(for: indexPath) else { return }
        
        var snapshot = diffableDataSource.snapshot()
        snapshot.deleteItems([objectClickled])
        diffableDataSource.apply(snapshot)
        
        
      }
      superview = superview?.superview
    }
    
    
    
  }
  
  
  
  @objc func handleFetchTopPaid() {
    
    Service.shared.fetchTopPaid { [weak self] (appGroup, error) in
      guard let self = self else { return }
      if let error = error {
        print("Failed to fetch Top Paid " + error.localizedDescription)
      }
      
      var snapshot = self.diffableDataSource.snapshot()
      
      snapshot.insertSections([.topPaid], afterSection: .games)
      snapshot.appendItems(appGroup?.feed.results ?? [], toSection: .topPaid)
      
      self.diffableDataSource.apply(snapshot)
      
    }
    
  }
  
  
  @objc func handleRefresh() {
    
    collectionView.refreshControl?.endRefreshing()
    
    //Handle Deletion
//    var snapshot = diffableDataSource.snapshot()
//
//    snapshot.deleteSections([.games])
//
//    diffableDataSource.apply(snapshot)
//
  }
  
  
 
  


  
  //MARK: - UICollectionView methods

  private func setupDiffableDatasourse() {
     
     //data to diffableDataSource
     
     collectionView.dataSource = diffableDataSource
     
     diffableDataSource.supplementaryViewProvider = .some({ (collectionView, kind, indexPath) -> UICollectionReusableView? in
       let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.headerId, for: indexPath) as! CompositionalHeader
       
       let snapshot = self.diffableDataSource.snapshot()
       guard let object = self.diffableDataSource.itemIdentifier(for: indexPath) else { return nil }
       let section = snapshot.sectionIdentifier(containingItem: object)
       
       switch section {
       case .games:
         header.label.text = "Games"
       case .topGrossing:
         header.label.text = "Top Grossing"
       case .topPaid:
         header.label.text = "Top Paid"
       default:
         header.label.text = ""
       }
       return header
     })
     
     Service.shared.fetchSocialApps { (socialApps, error) in
       if let error = error {
         print("Failed to fetch SocialApps " + error.localizedDescription)
       }
       
       
       Service.shared.fetchGames { (games, error) in
         if let error = error {
           print("Failed to fetch Games " + error.localizedDescription)
         }
         
         Service.shared.fetchTopGrossing { (topGrossing, error) in
           if let error = error {
             print("Failed to fetch topGrossing " + error.localizedDescription)
           }
           
           var snapshot = self.diffableDataSource.snapshot()
           
           //Social
           snapshot.appendSections([.topSocial, .games, .topGrossing])
           snapshot.appendItems(socialApps?.results ?? [], toSection: .topSocial)
           //GAMES
           let gamesObjects = games?.feed.results ?? []
           let topGrossingObjects = topGrossing?.feed.results ?? []
           snapshot.appendItems(gamesObjects, toSection: .games)
           snapshot.appendItems(topGrossingObjects, toSection: .topGrossing)
           self.diffableDataSource.apply(snapshot)
   
         }
       }
     }
     
     
   }
  
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let object = diffableDataSource.itemIdentifier(for: indexPath)
      
     if let object = object as? FeedResult {
      let appDetailController = AppsDetailsController(appId: object.id)
      navigationController?.pushViewController(appDetailController, animated: true)
    }
    
  }
  
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! CompositionalHeader
    var title: String?

    switch indexPath.section {
    case 1: title = games?.feed.title
    case 2: title = topGrossingApps?.feed.title
    case 3: title = topPaid?.feed.title
    default: title = "Apps"
    }

    header.label.text = title
    return header

  }
  
  
  
  
}
  

extension CompositionalController {
  
  func fetchAppsDispatchGroup() {
    
    let dispatchGroup = DispatchGroup()
    
    dispatchGroup.enter()
    Service.shared.fetchGames { (appGroup, error) in
      self.games = appGroup
      dispatchGroup.leave()
    }
    
    dispatchGroup.enter()
    Service.shared.fetchTopGrossing { (appGroup, error) in
      self.topGrossingApps = appGroup
      dispatchGroup.leave()
    }
    
    dispatchGroup.enter()
    Service.shared.fetchTopPaid { (appGroup, error) in
      self.topPaid = appGroup
      dispatchGroup.leave()
    }
    
    dispatchGroup.enter()
    Service.shared.fetchSocialApps { (apps, error) in
      dispatchGroup.leave()
      self.socialApps = apps?.results ?? []
    }
    
    dispatchGroup.notify(queue: .main) {
      self.collectionView.reloadData()
    }
  }
  
  
}
  








struct AppsView: UIViewControllerRepresentable {
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<AppsView>) -> UIViewController {
    let controller = CompositionalController()
    return UINavigationController(rootViewController: controller)
  }
  
  func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<AppsView>) {
    
  }
  
  
  
  typealias UIViewControllerType = UIViewController
  
  
  
  
  
  
}


struct AppsCompositionalView_Previews: PreviewProvider {
    static var previews: some View {
        AppsView()
          .edgesIgnoringSafeArea(.all)
          .colorScheme(.dark)
    }
}
