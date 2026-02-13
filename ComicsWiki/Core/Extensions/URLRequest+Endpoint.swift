//
//  URLRequest+Endpoint.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 13.02.2026.
//

import Foundation

extension URLRequest {
    init?(endpoint: Endpoint) {
        guard var components = URLComponents(
            url: endpoint.baseURL.appendingPathComponent(endpoint.path),
            resolvingAgainstBaseURL: false
        ) else { return nil }
        
        components.queryItems = endpoint.query.isEmpty ? nil : endpoint.query
        guard let url = components.url else { return nil }
        
        self.init(url: url)
        httpMethod = endpoint.method.rawValue
        httpBody = endpoint.body
        
        endpoint.headers.forEach { setValue($1, forHTTPHeaderField: $0) }
    }
}
