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
  
  let floatingContainerView = UIView()
  
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
    print(scrollView.contentOffset.y)
    if scrollView.contentOffset.y < 0 {
      scrollView.isScrollEnabled = false
      scrollView.isScrollEnabled = true
    }
    
    //If scroll down higher then 100 point then show animation with the view, scroll up less then 100 hide view with animation
    if scrollView.contentOffset.y > 100 {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
          let height = self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
          let translationY = -90 - height
          self.floatingContainerView.transform = .init(translationX: 0, y: translationY)
//          self.view.layer.cornerRadius = 25
        })
    } else {
      UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
        self.floatingContainerView.transform = .init(translationX: 0, y: 90)
      })
    }
    
  }
  
  fileprivate func setupCloseButton() {
    
    view.addSubview(closeButton)
    closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 12), size: .init(width: 36, height: 36))
  
  }
  
  // We populate todayItem in the cell section instead of using this in viewDidLoad were todayItem = nil
  fileprivate func setupFloatingControls() {
    
    floatingContainerView.layer.cornerRadius = 16
    floatingContainerView.clipsToBounds = true
    view.addSubview(floatingContainerView)
    
    floatingContainerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: -90, right: 16), size: .init(width: 0, height: 90))
    
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    floatingContainerView.addSubview(blurView)
    blurView.fillSuperview()
    
    // add our subviews
    let imageView = UIImageView(cornerRadius: 16)
    imageView.image = todayItem?.image
    imageView.constrainHeight(constant: 68)
    imageView.constrainWidth(constant: 68)
    
    let getButton = UIButton(title: "Watch")
    getButton.setTitleColor(.white, for: .normal)
    getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    getButton.backgroundColor = .lightGray
    getButton.layer.cornerRadius = 16
    getButton.constrainWidth(constant: 80)
    getButton.constrainHeight(constant: 32)
    
    let topLabel = UILabel(text: todayItem?.title ?? "", font: .boldSystemFont(ofSize: 20))
    topLabel.textColor = .white
    topLabel.numberOfLines = 0
    let bottomLabel = UILabel(text: todayItem?.releaseDate ?? "", font: .systemFont(ofSize: 16, weight: .regular))
    bottomLabel.textColor = .white
   
   
    
    let verticalStack = VerticalStackView(arrangedSubviews: [topLabel, bottomLabel], spacing: 4)
    
    let stackView = UIStackView(arrangedSubviews: [
      imageView,
      verticalStack,
      getButton
      ])
    stackView.spacing = 16
    
    floatingContainerView.addSubview(stackView)
    stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
    stackView.alignment = .center
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
      
       setupFloatingControls()
      
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



