//
//  AppsCompositionalView.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 11.03.2020.
//  Copyright © 2020 Igor Tkach. All rights reserved.
//

import SwiftUI

class CompositionalController: UICollectionViewController {
  
  //MARK: - Properties
  
  let cellId = "cellId"

  
  
  //MARK: - VC LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .systemBackground
    navigationItem.title = "Apps"
    navigationController?.navigationBar.prefersLargeTitles = true
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
  }
  
  
  
  //MARK: - Class Init
  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  //MARK: - UICollectionView methods
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    cell.backgroundColor = .red
    return cell
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
