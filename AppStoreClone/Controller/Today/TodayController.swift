//
//  TodayController.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/23/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit



class TodayController: BaseListController {
  
  
  //MARK: - Properties

  fileprivate let headerId = "headerId"
  
  var activityIndicatiorView: UIActivityIndicatorView = {
    let ai = UIActivityIndicatorView(style: .whiteLarge)
    ai.color = .darkGray
    ai.startAnimating()
    ai.hidesWhenStopped = true
    return ai
  }()
  
  
  var topPaidGroup: AppGroup?
  var gamesGroup: AppGroup?
  
  static let cellSize: CGFloat = 450
  
  var items = [TodayItem]()
  
  let padding: CGFloat = 64
  let lineSpacing: CGFloat = 32
  
  let date = Date()
  let format = DateFormatter()
  
  var startingFrame: CGRect?
  let appFullscreenController = AppFullscreenController()
  let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
  var appFullscreenBeginOffset: CGFloat = 0
  
  //Constraint
  var topConstraint: NSLayoutConstraint?
  var leadingConstraint: NSLayoutConstraint?
  var trailingAnchor: NSLayoutConstraint?
  var bottomAnchor: NSLayoutConstraint?
  
  
  //MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(activityIndicatiorView)
    view.addSubview(blurVisualEffectView)
    blurVisualEffectView.fillSuperview()
    blurVisualEffectView.alpha = 0
    
    activityIndicatiorView.centerInSuperview()
    
    format.dateFormat = "EEEE dd MMMM"
    collectionView.backgroundColor = #colorLiteral(red: 0.9234003425, green: 0.9234003425, blue: 0.9234003425, alpha: 1)
    
    collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
    collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
    collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    
    fetchData()
    
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.isNavigationBarHidden = true
    tabBarController?.tabBar.superview?.setNeedsLayout()
  }
  
  fileprivate func fetchData() {
    
    //dispatchGroup
    
    let dispatchGroup = DispatchGroup()
    
    dispatchGroup.enter()
    Service.shared.fetchGames { (appGroup, error) in
      if let error = error {
        print(error)
      }
      
      self.gamesGroup = appGroup
      dispatchGroup.leave()
      
    }
    
    dispatchGroup.enter()
    Service.shared.fetchTopPaid { (appGroup, error) in
      if let error = error {
        print(error)
      }
      
      self.topPaidGroup = appGroup
      dispatchGroup.leave()
    }
    
    
    
    dispatchGroup.notify(queue: .main) {
      // access to top paid end games
      print("Finished fetching")
      self.activityIndicatiorView.stopAnimating()
      
      self.items = [
        TodayItem.init(releaseDate: "Daily List", title: self.topPaidGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "star"), cellType: .multiple, apps: self.topPaidGroup?.feed.results ?? []),
        TodayItem.init(releaseDate: "May 17", title: "John Wick 3", image: #imageLiteral(resourceName: "wick3"), cellType: .single, apps: []),
        TodayItem.init(releaseDate: "June 6", title: "X-Men: Dark Phoenix", image: #imageLiteral(resourceName: "xmen"), cellType: .single, apps: []),
        TodayItem.init(releaseDate: "Daily List", title: self.gamesGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "spider"), cellType: .multiple, apps: self.gamesGroup?.feed.results ?? []),
        TodayItem.init(releaseDate: "July 5", title: "Spider-Man: Far From Home", image: #imageLiteral(resourceName: "spider"), cellType: .single, apps: []),
        TodayItem.init(releaseDate: "April 24", title: "AVENGERS: ENDGAME", image: #imageLiteral(resourceName: "avengers"), cellType: .single, apps: [])
      ]
  
      
      self.collectionView.reloadData()
    }
    
  }
  
  //Allow you to tap on the cell
  @objc func handleMultipleAppsTap(_ gesture: UIGestureRecognizer) {
    
    let collectionView = gesture.view
    
    //wich cell we clicking in
    var superview = collectionView?.superview
    
    while superview != nil {
      if let cell = superview as? TodayMultipleAppCell {
        guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
        
        let apps = self.items[indexPath.item].apps
        
        let fullController = TodayMultipleAppsController(mode: .fullscreen)
        fullController.apps = apps
        present(BackEnabledNavigationController(rootViewController: fullController), animated: true)
        return
      }
      
      superview = superview?.superview
    }
    
  }
  

  
  
  //MARK: - Data Source
  
  //HEADER
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderView
    let result = format.string(from: date)
    header.dateLabel.text = result.uppercased()
    
    return header
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return .init(width: view.frame.width, height: 100)
  }
  
  
  
  //CELLS
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
    let cellType = items[indexPath.item].cellType.rawValue
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType, for: indexPath)
    
    if let cell = cell as? TodayCell {
      cell.todayItem = items[indexPath.item]
    } else if let cell = cell as? TodayMultipleAppCell {
      cell.multipleAppController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppsTap)))
      cell.todayItem = items[indexPath.item]
    }
    
    return cell
    
  }


  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    switch items[indexPath.item].cellType {
    case .multiple:
      showDailyListFullScreen(indexPath)
    case .single:
      showSingleAppFullScreen(indexPath: indexPath)
    }
  }
  
  //MARK: Data Source Helper
  //Show the app list
  fileprivate func showDailyListFullScreen(_ indexPath: IndexPath) {
    let fullController = TodayMultipleAppsController(mode: .fullscreen)
    fullController.apps = self.items[indexPath.item].apps
    present(BackEnabledNavigationController(rootViewController: fullController), animated: true)
  }
  
  //Show the movie
  fileprivate func showSingleAppFullScreen(indexPath: IndexPath) {
    
    
    guard let fullscreenView = appFullscreenController.view else { return }
    
    
    // #1 Gesture recognizer
    let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleDrag))
    gesture.delegate = self
    appFullscreenController.view.addGestureRecognizer(gesture)
    
    
    // #2 Add blur effect view
    
    
    
    // #3 not to interfare with our UITableView scrolling
    
    //Setup the model
    appFullscreenController.todayItem = items[indexPath.row]
    
    //Closure passing tap the dissmiss button
    appFullscreenController.dismissHandler = {
      self.handleRemoveFullScreenView()
    }
    
    // #1 setup fullscreen in it's starting position
    setupStartingPosition(indexPath: indexPath)
    
    // #2 Animation
    beginAnimationFullScreen(view: fullscreenView)
  }
  
  
  
  @objc fileprivate func handleDrag(_ gesture: UIPanGestureRecognizer) {
    
    if gesture.state == .began {
      appFullscreenBeginOffset = appFullscreenController.tableView.contentOffset.y
    }
  
    if appFullscreenController.tableView.contentOffset.y > 0 {
      return
    }
    
    let translationY = gesture.translation(in: appFullscreenController.view).y
    
    if gesture.state == .changed {
      if translationY > 0 {
        
        let trueOffset = translationY - appFullscreenBeginOffset
        
        var scale = 1 - trueOffset / 1000
        
        scale = min(1, scale)
        scale = max(0.6, scale)
        
        if scale < 1 {
          appFullscreenController.view.layer.cornerRadius = 25
        }
        
        let transform: CGAffineTransform = .init(scaleX: scale, y: scale)
        self.appFullscreenController.view.transform = transform
      }
    }
    if gesture.state == .ended {
      if translationY > 0 {
        handleRemoveFullScreenView()
      }
      
    }
  }
  
  
  fileprivate func startingCellFrame(indexPath: IndexPath) {
    
    guard let cell = collectionView.cellForItem(at: indexPath) else { return }
    //absolute coordinates of cell
    guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
    
    self.startingFrame = startingFrame
  }

  
  fileprivate func setupStartingPosition(indexPath: IndexPath) {
    
    guard let fullscreenView = appFullscreenController.view else { return }
    
    fullscreenView.layer.cornerRadius = 16
    
    view.addSubview(fullscreenView)
    
    fullscreenView.layer.opacity = 1
    
    self.appFullscreenController.closeButton.alpha = 1
    
    fullscreenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveFullScreenView)))
    
    self.collectionView.isUserInteractionEnabled = false
    
    //return a spacific cell
    
    startingCellFrame(indexPath: indexPath)
    
    guard let startingFrame = self.startingFrame else { return }
    
    //auto layout 4 constraint animations
    fullscreenView.translatesAutoresizingMaskIntoConstraints = false
    topConstraint = fullscreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
    leadingConstraint = fullscreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
    trailingAnchor = fullscreenView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -startingFrame.origin.x)
    bottomAnchor = fullscreenView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -startingFrame.origin.y)
    
    [topConstraint, leadingConstraint, trailingAnchor, bottomAnchor].forEach { $0?.isActive = true }
    
    self.view.layoutIfNeeded()
  }
  
  
  fileprivate func beginAnimationFullScreen(view: UIView) {
  
  UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: { [unowned self] in
  
  self.blurVisualEffectView.alpha = 1
    
  self.topConstraint?.constant = 0
  self.leadingConstraint?.constant = 0
  self.trailingAnchor?.constant = 0
  self.bottomAnchor?.constant = 0
  
  self.view.layoutIfNeeded()
  
  view.layer.cornerRadius = 0
  self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
  
  })
  }
  
  
  
  @objc func handleRemoveFullScreenView() {
    
    
    UIView.animate(withDuration: 0.45, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: { [unowned self] in
      
      guard let fullscreenView = self.appFullscreenController.view else { return }
      guard let startingFrame = self.startingFrame else { return }
      
      self.blurVisualEffectView.alpha = 0
      self.appFullscreenController.view.transform = .identity
      
      self.topConstraint?.constant = startingFrame.origin.y
      self.leadingConstraint?.constant = startingFrame.origin.x
      self.trailingAnchor?.constant = -startingFrame.origin.x
      self.bottomAnchor?.constant = startingFrame.origin.y
      
     
    
      self.appFullscreenController.closeButton.alpha = 0
      
      fullscreenView.layer.cornerRadius = 24
      self.tabBarController?.tabBar.transform = .identity
       self.view.layoutIfNeeded()
      
      
    }, completion: { _ in
      self.appFullscreenController.view.removeFromSuperview()
      self.collectionView.isUserInteractionEnabled = true
    })
  }
  
}



extension TodayController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width - padding, height: TodayController.cellSize)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return lineSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return . init(top: lineSpacing / 2, left: 0, bottom: lineSpacing, right: 0)
  }
  
}



extension TodayController : UIGestureRecognizerDelegate {
  
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
  
}
