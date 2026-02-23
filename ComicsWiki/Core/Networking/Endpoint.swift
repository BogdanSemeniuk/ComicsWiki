//
//  Endpoint.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 13.02.2026.
//

import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var query: [URLQueryItem] { get }
    var headers: [String: String] { get }
    var body: Data? { get }
}

enum APIEndpoint: Endpoint {
    case login(email: String, password: String)
    
    var baseURL: URL { URL(string: "https://domain.com")! }
    
    var path: String {
        switch self {
        case .login: return "session"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login: return .POST
        }
    }
    
    var query: [URLQueryItem] {
        switch self {
        case .login: return []
        }
    }
    
    var headers: [String: String] {
        [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
    
    var body: Data? {
        switch self {
        case let .login(email, password):
            let json: [String: Any] = ["email": email, "password": password]
            return try? JSONSerialization.data(withJSONObject: json, options: [])
        }
    }
}
