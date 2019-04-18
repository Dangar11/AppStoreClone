//
//  SearchrResult.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/15/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import Foundation


struct SearchResult: Decodable {
  let resultCount: Int
  let results: [ResultJSON]
  
}

struct ResultJSON: Decodable {
  let trackName: String
  let primaryGenreName: String
  var averageUserRating: Float?
  let screenshotUrls: [String]
  let artworkUrl100: String // appIcon
  let formattedPrice: String
  let description: String
  let releaseNotes: String
}



