//
//  AppGroup.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/16/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import Foundation


struct AppGroup: Decodable {
  
  let feed: Feed
  
}

struct Feed: Decodable {
  let title: String
  let results: [FeedResult]
}


struct FeedResult: Decodable {
  let artistName: String
  let name: String
  let artworkUrl100: String
}

