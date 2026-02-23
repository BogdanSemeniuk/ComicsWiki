//
//  URLSession+Mock.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 23.02.2026.
//

import Foundation

extension URLSession {
    static var mockedSession: URLSession {
        let config = URLSessionConfiguration.ephemeral
        try? URLSession.setupMockResponses()
        config.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: config)
    }
    
    static func setupMockResponses() throws {
        let loginData = try JSONEncoder().encode(Session(token: UUID().uuidString))
        guard let loginRemotePath = URLRequest(endpoint: APIEndpoint.login(email: "", password: ""))?.url?.absoluteString else { return }
        MockURLProtocol.responses[loginRemotePath] = .init(statusCode: 200, data: loginData)
    }
}
