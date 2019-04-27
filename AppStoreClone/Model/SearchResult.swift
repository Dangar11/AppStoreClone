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
  var screenshotUrls: [String]?
  let artworkUrl100: String // appIcon
  var artworkUrl512: String?
  var formattedPrice: String?
  var description: String?
  var releaseNotes: String?
  var artistName: String?
  var collectionName: String?
}



