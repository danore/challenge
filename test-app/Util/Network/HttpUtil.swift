//
//  HttpCode.swift
//  test-app
//
//  Created by Daniel Orellana on 22/06/21.
//

import Foundation

enum HttpCode: Int {
    
    case success
    case created
    case not_content
    case bad_request
    case authorized
    case forbidden
    case not_found
    case method_not_allowed
    case server_error
    
    static func code(_ code: Int) -> HttpCode {
        switch code {
        case 200:
            return .success
        case 201:
            return .created
        case 204:
            return .not_content
        case 400:
            return .bad_request
        case 401:
            return .authorized
        case 403:
            return .forbidden
        case 404:
            return .not_found
        case 405:
            return .method_not_allowed
        default:
            return .server_error
        }
    }
}

enum HttpMethod: String {
    
    case post
    case put
    case get
    case delete
    
    var value: String? {
        switch self {
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .get:
            return "GET"
        case .delete:
            return "DELETE"
        }
    }
}
