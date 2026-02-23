//
//  HTTPResponse.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 23.02.2026.
//

import Foundation

struct HTTPResponse {
    var statusCode: Int = 200
    var data: Data?
    var headers: [String: String] = ["Content-Type": "application/json"]
    var error: Error?
}
