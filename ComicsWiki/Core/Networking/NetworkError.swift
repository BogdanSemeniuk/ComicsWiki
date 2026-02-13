//
//  NetworkError.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 13.02.2026.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case decoding(String)
    case transport(String)
}
