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
  case topGrossingApps
  case topPaid
}


class CompositionalController: UICollectionViewController {
  
  //MARK: - Properties
  
  var socialApps = [ResultHeader]()
  var games: AppGroup?
  var topGrossingApps: AppGroup?
  var topPaid: AppGroup?
  
  
  lazy var diffableDataSource: UICollectionViewDiffableDataSource<AppSection, ResultHeader> = .init(collectionView: self.collectionView) { [ weak self] (collectionView, indexPath, socialApp) -> UICollectionViewCell? in
    guard let self = self else { return nil}
    
    let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: self.topCellId, for: indexPath) as! AppsHeaderCell
    cell.app = socialApp
    return cell
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
  
  
  private func setupDiffableDatasourse() {
    
    //data to diffableDataSource
    
    var snapshot = diffableDataSource.snapshot()
    
    
    collectionView.dataSource = diffableDataSource
    
    Service.shared.fetchSocialApps { (socialApps, error) in
      if let error = error {
        print("Failed to fetch SocialApps " + error.localizedDescription)
      }
      
      snapshot.appendSections([.topSocial])
      snapshot.appendItems(socialApps?.results ?? [], toSection: .topSocial)
      self.diffableDataSource.apply(snapshot)
      
    }
  }
  


  
  //MARK: - UICollectionView methods
//  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    switch section {
//    case 0: return socialApps.count
//    case 1: return games?.feed.results.count ?? 0
//    case 2: return topGrossingApps?.feed.results.count ?? 0
//    case 3: return topPaid?.feed.results.count ?? 0
//    default: return 0
//    }
//
//  }
  
  
  
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
  
  
  
//  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    switch indexPath.section {
//    case 0:
//      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topCellId, for: indexPath) as! AppsHeaderCell
//      let socialApp = self.socialApps[indexPath.item]
//      cell.companyLabel.text = socialApp.artistName
//      cell.titleLabel.text = socialApp.description
//      cell.imageView.sd_setImage(with: URL(string: socialApp.artworkUrl512))
//      return cell
//    default:
//      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: centerCellid, for: indexPath) as! AppRowCell
//      var appGroup: AppGroup?
//      switch indexPath.section {
//      case 1: appGroup = games
//      case 2: appGroup = topGrossingApps
//      case 3: appGroup = topPaid
//      default: appGroup = topPaid
//      }
//      cell.app = appGroup?.feed.results[indexPath.item]
//      return cell
//    }
//
//  }
  
  
  
  
//  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    let appId: String
//    switch indexPath.section {
//    case 0: return
//    case 1:
//      appId = games?.feed.results[indexPath.item].id ?? ""
//    case 2:
//      appId = topGrossingApps?.feed.results[indexPath.item].id ?? ""
//    case 3:
//      appId = topPaid?.feed.results[indexPath.item].id ?? ""
//    default: return
//    }
//    let gamesDetailController = AppsDetailsController(appId: appId)
//     navigationController?.pushViewController(gamesDetailController, animated: true)
//
//  }
  
  
  
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
    }
}
