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
  func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
    
    let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
    guard let url = URL(string: urlString) else { return }
    
    //fetch data from internet
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      if let error = error {
        print(error.localizedDescription)
        completion([], error)
        return
      }
      
      //success
      guard let data = data else { return }
      
      //JSON Parse
      do {
        let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
        
        //Completion call
        completion(searchResult.results, nil)
        
      } catch let errorJson {
        completion([], errorJson)
        print("Failed to decode json:", errorJson)
      }
      
      }.resume()

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
    
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      //Error handling
      if let error = error {
        completion(nil, error)
        return
      }
      
      //success
      
      guard let data = data else { return }
      
      do {
        let appGroup = try JSONDecoder().decode(AppGroup.self, from: data)
        completion(appGroup, nil)
      } catch let errorJson {
        completion(nil, errorJson)
        print("Failed to decode:", errorJson)
      }
      }.resume()
    
  }
  
  
  //MARK: - Fetch for Header
  
  func fetchSocialApps(completion: @escaping ([ResultHeader], Error?) -> ()) {
    
  let urlString = "https://itunes.apple.com/search?term=social&country=ua&entity=software&limit=25"
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      if let error = error {
        completion([], error)
        return
      }
      
      guard let data = data else { return }
      
      do {
        let socialGroup = try JSONDecoder().decode(HeaderGroup.self, from: data)
        completion(socialGroup.results, nil)
      } catch let errorJson {
        completion([], errorJson)
      }
      
    }.resume()
  }
  
  
  
}
