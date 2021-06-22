//
//  HomeViewModel.swift
//  test-app
//
//  Created by Daniel Orellana on 22/06/21.
//

import Foundation

class MovieViewModel {
    
    static var shared = MovieViewModel()
    
    var webService: NetworkManager
    
    private init() {
        self.webService = NetworkManager()
    }
    
    func fetchData(_ completion: @escaping ([MovieModel]?) ->(), onFailure: @escaping (String) -> ()) {
        self.webService.request(API_URI, method: .get) { data in
            guard let info = data else {
                onFailure("Results not found")
                return
            }
            
            do {
                let result = try JSONDecoder().decode([MovieModel].self, from: info)
                completion(result)
            }catch {
                print("ERROR:", error)
                onFailure("Parse data error")
            }
        }
    }
    
}
