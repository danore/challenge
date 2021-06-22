//
//  NetworkManager.swift
//  test-app
//
//  Created by Daniel Orellana on 22/06/21.
//

import Foundation

class NetworkManager {
    
    func request(_ uri: String, params: [String: Any]? = nil, queryParams: [String: Any]? = nil, method: HttpMethod, completion: @escaping (Data?) -> ()) {
        guard var components = URLComponents(string: uri) else {
            fatalError("Invalid URL")
        }
        
        if queryParams != nil && (method == .get || method == .delete || method == .put) {
            components.setQueryItems(with: queryParams!)
        }
        
        var request = URLRequest(url: components.url!)
        
        request.httpMethod = method.value
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if params != nil && (method == .post || method == .put) {
            request.httpBody = try! JSONSerialization.data(withJSONObject: params!)
        }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 60.0
        let session = URLSession(configuration: sessionConfig)
        
        session.dataTask(with: request) { data, response, error in
            let response = response as? HTTPURLResponse
            let httpCode = HttpCode.code(response?.statusCode ?? 500)
                        
            if httpCode != .server_error {
                guard let data = data, error == nil else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion(data)
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}
