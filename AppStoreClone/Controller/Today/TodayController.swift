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
  fileprivate let cellId = "todayCell"
  fileprivate let headerId = "headerId"
  
  let padding: CGFloat = 64
  let lineSpacing: CGFloat = 32
  
  let date = Date()
  let format = DateFormatter()
  
  var startingFrame: CGRect?
  let redView = UIView()
  
  
  //MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    format.dateFormat = "EEEE dd MMMM"
    collectionView.backgroundColor = #colorLiteral(red: 0.9234003425, green: 0.9234003425, blue: 0.9234003425, alpha: 1)
    
    collectionView.register(TodayCell.self, forCellWithReuseIdentifier: cellId)
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
    return 5
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TodayCell
    return cell
  }
  
  
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    redView.backgroundColor = .red
    redView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveRedView)))
    view.addSubview(redView)
    
    guard let cell = collectionView.cellForItem(at: indexPath) else { return }
    print(cell.frame)
    //absolute coordinates of cell
    guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
    
    self.startingFrame = startingFrame
    
    redView.frame = startingFrame
    redView.layer.cornerRadius = 16
    
    //Animation
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
      self.redView.frame = self.view.frame
      self.redView.layer.cornerRadius = 0
    })
    
  }
  
  @objc func handleRemoveRedView(gesture: UITapGestureRecognizer) {
//    gesture.view?.removeFromSuperview()
    
    //access startingFrame
    
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
      gesture.view?.frame = self.startingFrame ?? .zero
      self.redView.layer.cornerRadius = 16
    }, completion: { _ in
      gesture.view?.removeFromSuperview()
    })
  }
  
}



extension TodayController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width - padding, height: 400)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return lineSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return . init(top: lineSpacing / 2, left: 0, bottom: lineSpacing, right: 0)
  }
  
}
