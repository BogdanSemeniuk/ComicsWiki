//
//  HTTPClient.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 13.02.2026.
//

import Foundation

protocol HTTPClient {
    func send<T: Decodable>(_ endpoint: Endpoint, as type: T.Type) async throws -> T
}

struct LiveHTTPClient: HTTPClient {
    var session: URLSession
    var decoder: JSONDecoder

    init(
        session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }

    func send<T: Decodable>(_ endpoint: Endpoint, as type: T.Type) async throws -> T {
        guard let request = URLRequest(endpoint: endpoint) else { throw NetworkError.badRequest }

        do {
            let (data, _) = try await session.data(for: request)
            do { return try decoder.decode(T.self, from: data) }
            catch { throw NetworkError.decoding(error.localizedDescription) }
        } catch {
            throw NetworkError.transport(error.localizedDescription)
        }
    }
}

