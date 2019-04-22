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
  let trackId: Int
  let trackName: String
  let primaryGenreName: String
  var averageUserRating: Float?
  let screenshotUrls: [String]
  let artworkUrl100: String // appIcon
  let artworkUrl512: String
  var formattedPrice: String?
  let description: String
  var releaseNotes: String?
}



