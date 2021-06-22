//
//  Extension+Helper.swift
//  test-app
//
//  Created by Daniel Orellana on 22/06/21.
//

import Foundation

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: Any]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value as? String) }
    }
    
}
