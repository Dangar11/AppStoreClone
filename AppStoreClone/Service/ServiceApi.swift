//
//  ServiceApi.swift
//  AppStoreClone
//
//  Created by Igor Tkach on 4/15/19.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import Foundation


class Service {
  
  
  static let shared = Service() // singleton
  

  //MARK: - Fetching the search item API
  func fetchApps(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> ()) {
    
    let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
    
    fetchGenericJSONData(urlString: urlString, completion: completion)

  }
  
  
  //MARK: - Fetching games item JSON
  
  func fetchTopGrossing(completion: @escaping (AppGroup?, Error?) -> ()) {
    let urlString = "https://rss.itunes.apple.com/api/v1/ua/ios-apps/top-grossing/all/50/explicit.json"
    fetchAppGroup(urlString: urlString, completion: completion)
  }
  
  
  func fetchGames(completion: @escaping (AppGroup?, Error?) -> ()) {
    let urlString = "https://rss.itunes.apple.com/api/v1/ua/ios-apps/new-games-we-love/all/50/explicit.json"
    fetchAppGroup(urlString: urlString, completion: completion)
  }
  
  
  func fetchTopPaid(completion: @escaping (AppGroup?, Error?) -> ()) {
    let urlString = "https://rss.itunes.apple.com/api/v1/ua/ios-apps/top-paid/all/50/explicit.json"
    fetchAppGroup(urlString: urlString, completion: completion)
  }
  
  
  
  
  //helper method
  func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
    
    
    fetchGenericJSONData(urlString: urlString, completion: completion)
    
    
  }
  
  
  //MARK: - Fetch for Header
  
  func fetchSocialApps(completion: @escaping (HeaderGroup?, Error?) -> ()) {
    
  let urlString = "https://itunes.apple.com/search?term=social&country=ua&entity=software&limit=25"
    
    fetchGenericJSONData(urlString: urlString, completion: completion)
    

  }
  
  
  func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
    
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      if let error = error {
        completion(nil, error)
        return
      }
      
      guard let data = data else { return }
      
      do {
        let socialGroup = try JSONDecoder().decode(T.self, from: data)
        completion(socialGroup, nil)
      } catch let errorJson {
        completion(nil, errorJson)
      }
      
      }.resume()
    
    
  }
  
}
