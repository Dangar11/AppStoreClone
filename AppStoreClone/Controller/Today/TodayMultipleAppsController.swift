//
//  TodayMultipleAppsController.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/24/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit

enum Mode {
  case small, fullscreen
}


class TodayMultipleAppsController: BaseListController {
  
  
  //MARK: - Properties
  let cellId = "cellId"
  
  var apps = [FeedResult]()
  
  let closeButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "close").withRenderingMode(.alwaysOriginal), for: .normal)
    button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
    return button
  }()
  
  
  fileprivate let mode: Mode
  
  fileprivate let spacing: CGFloat = 16
  
  
  
  
  //View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if mode == .fullscreen {
      setupCloseButton()
      navigationController?.isNavigationBarHidden = true
    } else {
      collectionView.isScrollEnabled = false
    }
    
    collectionView.backgroundColor = .white
    collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: cellId)
    
    
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  init(mode: Mode) {
    self.mode = mode
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
  //MARK: - Methods
  @objc func handleDismiss() {
    dismiss(animated: true)
  }
  
  fileprivate func setupCloseButton() {
    view.addSubview(closeButton)
    closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 16, right: 24), size: .init(width: 36, height: 36))
  }
  
  
  //MARK: DataSource
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if mode == .fullscreen {
      return apps.count
    }
    return min(3, apps.count)
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MultipleAppCell
    cell.app = apps[indexPath.item]
    return cell
  }

  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let appId = self.apps[indexPath.item].id
    let appDetailController = AppsDetailsController(appId: appId)
    navigationController?.pushViewController(appDetailController, animated: true)
  }
  
  
  
}

extension TodayMultipleAppsController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let height: CGFloat = 74
    if mode == .fullscreen {
      return .init(width: view.frame.width - 48, height: height)
    }
    return .init(width: view.frame.width, height: height)
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return spacing
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    if mode == .fullscreen {
      return .init(top: 44, left: 24, bottom: 12, right: 24)
    }
    return .zero
  }
}
