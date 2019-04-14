//
//  AppsSearchController.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/14/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class AppsSearchController: UICollectionViewController {


  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .red
  }
  
  
  
  
  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  

}
