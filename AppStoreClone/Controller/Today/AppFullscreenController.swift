//
//  AppFullscreenController.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/23/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class AppFullscreenController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  var dismissHandler: (() ->())?
  var todayItem: TodayItem?
  
  let closeButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "close").withRenderingMode(.alwaysOriginal), for: .normal)
    return button
  }()
  
  let tableView = UITableView(frame: .zero, style: .plain)
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.clipsToBounds = true
    
    view.addSubview(tableView)
    tableView.fillSuperview()
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.tableFooterView = UIView()
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
    tableView.contentInsetAdjustmentBehavior = .never
    
    setupCloseButton()

    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    tableView.reloadData()
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y < 0 {
      scrollView.isScrollEnabled = false
      scrollView.isScrollEnabled = true
    }
  }
  
  fileprivate func setupCloseButton() {
    
    view.addSubview(closeButton)
    closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 12), size: .init(width: 36, height: 36))
  
  }
  
 
  //MARK: - Data Source

  
  
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.item == 0 {
      let headerCell = AppFullscreenHeaderCell()
      closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
      headerCell.todayCell.todayItem = todayItem
      headerCell.todayCell.layer.cornerRadius = 0
      headerCell.todayCell.backgroundView = nil
      
      return headerCell
    }
    
    let cell = AppFullscreenCell()
    return cell
  }
  
  @objc fileprivate func handleDismiss(_ button: UIButton) {
    dismissHandler?()
  }
  
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      return TodayController.cellSize
    }
    return UITableView.automaticDimension
  }
  
}



