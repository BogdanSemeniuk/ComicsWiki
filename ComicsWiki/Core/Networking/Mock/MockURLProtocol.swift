//
//  MockURLProtocol.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 23.02.2026.
//

import Foundation

class MockURLProtocol: URLProtocol {
    static var responses: [String: HTTPResponse] = [:]

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let url = request.url,
              let stub = Self.responses[url.absoluteString] else {
            client?.urlProtocol(self, didFailWithError: URLError(.badURL))
            return
        }
        if let error = stub.error {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            let response = HTTPURLResponse(
                url: url,
                statusCode: stub.statusCode,
                httpVersion: nil,
                headerFields: stub.headers
            )!
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            
            if let data = stub.data {
                client?.urlProtocol(self, didLoad: data)
            }
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
