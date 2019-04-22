//
//  Review.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/22/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import Foundation



struct Reviews: Decodable {
  let feed: ReviewFeed
}


struct ReviewFeed: Decodable {
  let entry: [Entry]
}


struct Entry: Decodable {
  let title: Label
  let content: Label
  let author: Author
}


struct Author: Decodable {
  let name: Label
}

struct Label: Decodable {
  let label: String
}



