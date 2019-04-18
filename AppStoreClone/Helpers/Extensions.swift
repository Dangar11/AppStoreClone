//
//  Extensions.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/15/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


extension UILabel {
  
  convenience init(text: String, font: UIFont, numberOfLines: Int = 1) {
    self.init(frame: .zero)
    self.text = text
    self.font = font
    self.numberOfLines = numberOfLines
  }
  
}


extension UIImageView {
  
  convenience init(cornerRadius: CGFloat) {
    self.init(image: nil)
    self.layer.cornerRadius = cornerRadius
    self.clipsToBounds = true
    self.contentMode = .scaleAspectFill
  }
}



extension UIButton {
  convenience init(title: String) {
    self.init(type: .system)
    self.setTitle(title, for: .normal)
  }
}

//Trim string to a first given character and return that trimed string 
extension String {
  func trimStringToSign(sign: String) -> String {
    let string = self.components(separatedBy: sign)
    return string[0]
  }
}
