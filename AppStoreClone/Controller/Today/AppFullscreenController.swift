//
//  AppFullscreenController.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/23/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class AppFullscreenController: UITableViewController {
  
  var dismissHandler: (() ->())?
  var todayItem: TodayItem?
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.tableFooterView = UIView()
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
  }
  
  override func viewWillAppear(_ animated: Bool) {
    tableView.reloadData()
  }
  
 
  //MARK: - Data Source

  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.item == 0 {
      let headerCell = AppFullscreenHeaderCell()
      headerCell.closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
      headerCell.todayCell.todayItem = todayItem
      headerCell.todayCell.layer.cornerRadius = 0
      
      return headerCell
    }
    
    
    
    let cell = AppFullscreenCell()
    return cell
  }
  
  @objc fileprivate func handleDismiss(_ button: UIButton) {
    dismissHandler?()
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      return 450
    }
    return super.tableView(tableView, heightForRowAt: indexPath)
  }
  
}



