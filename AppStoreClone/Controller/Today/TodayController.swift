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
//  fileprivate let cellId = "todayCell"
  fileprivate let headerId = "headerId"
//  fileprivate let multipleCellId = "multipleCellId"
  
  static let cellSize: CGFloat = 450
  
  let items = [
  TodayItem.init(category: "Action", title: "Avangers", image: #imageLiteral(resourceName: "avengers"), cellType: .single),
  TodayItem.init(category: "Action", title: "John Wick", image: #imageLiteral(resourceName: "wick3"), cellType: .single),
  TodayItem.init(category: "Life Hack", title: "It's the best life hack in the world", image: #imageLiteral(resourceName: "star"), cellType: .multiple),
  TodayItem.init(category: "Action", title: "2", image: #imageLiteral(resourceName: "xmen"), cellType: .single),
  TodayItem.init(category: "Action", title: "2", image: #imageLiteral(resourceName: "men-in-black"), cellType: .multiple),
  TodayItem.init(category: "Action", title: "2", image: #imageLiteral(resourceName: "spider"), cellType: .single)
  
  ]
  
  let padding: CGFloat = 64
  let lineSpacing: CGFloat = 32
  
  let date = Date()
  let format = DateFormatter()
  
  var startingFrame: CGRect?
  let appFullscreenController = AppFullscreenController()
  
  //Constraint
  var topConstraint: NSLayoutConstraint?
  var leadingConstraint: NSLayoutConstraint?
  var widthConstraint: NSLayoutConstraint?
  var heightConstraint: NSLayoutConstraint?
  
  
  //MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    format.dateFormat = "EEEE dd MMMM"
    collectionView.backgroundColor = #colorLiteral(red: 0.9234003425, green: 0.9234003425, blue: 0.9234003425, alpha: 1)
    
    collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
    collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
    collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.isNavigationBarHidden = true
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
      cell.todayItem = items[indexPath.item]
    }
    
    return cell
    
  }


  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    guard let fullscreenView = appFullscreenController.view else { return }
    appFullscreenController.todayItem = items[indexPath.row]
    //Closure passing tap the dissmiss button
    appFullscreenController.dismissHandler = {
      self.handleRemoveFullScreenView()
    }
    

    
    view.addSubview(fullscreenView)
    
    fullscreenView.layer.opacity = 1
    
    fullscreenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveFullScreenView)))
    
    self.collectionView.isUserInteractionEnabled = false
    
    //return a spacific cell
    guard let cell = collectionView.cellForItem(at: indexPath) else { return }
    //absolute coordinates of cell
    guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
    
    self.startingFrame = startingFrame
    
    //auto layout constaint animations
    fullscreenView.translatesAutoresizingMaskIntoConstraints = false
    topConstraint = fullscreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
    leadingConstraint = fullscreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
    widthConstraint = fullscreenView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -startingFrame.origin.x)
    heightConstraint = fullscreenView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -startingFrame.origin.y)
    
    [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach { $0?.isActive = true }
    
    self.view.layoutIfNeeded()
    
    fullscreenView.layer.cornerRadius = 16
    
    
    //we're using frames for animations
    //frames aren't reliable enough for animations
    
    //Animation
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: { [unowned self] in
      
      self.topConstraint?.constant = 0
      self.leadingConstraint?.constant = 0
      self.widthConstraint?.constant = 0
      self.heightConstraint?.constant = 0
      
      
      self.view.layoutIfNeeded()

      fullscreenView.layer.cornerRadius = 0
      self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)

    })
    
  }
  
  @objc func handleRemoveFullScreenView() {
    
    //access startingFrame
    
    
    
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: { [unowned self] in
      
      //
      guard let fullscreenView = self.appFullscreenController.view else { return }
      guard let startingFrame = self.startingFrame else { return }
      
      
      self.topConstraint?.constant = startingFrame.origin.y
      self.leadingConstraint?.constant = startingFrame.origin.x
      self.widthConstraint?.constant = -startingFrame.origin.x
      self.heightConstraint?.constant = -startingFrame.origin.y
      
      self.view.layoutIfNeeded()
      
      fullscreenView.layer.cornerRadius = 24
      self.tabBarController?.tabBar.transform = .identity
      
      UIView.animate(withDuration: 0.3, delay: 0.3, animations: {
        fullscreenView.layer.opacity = 0.0
      })
      
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
