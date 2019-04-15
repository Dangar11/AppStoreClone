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
  
}
