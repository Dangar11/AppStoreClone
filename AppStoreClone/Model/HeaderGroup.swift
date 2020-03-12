//
//  HeaderGroup.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/17/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import Foundation



struct HeaderGroup: Decodable {
  let resultCount: Int
  let results: [ResultHeader]
}


struct ResultHeader: Decodable, Hashable {
  let description: String
  let artistName: String
  let artworkUrl512: String
}
