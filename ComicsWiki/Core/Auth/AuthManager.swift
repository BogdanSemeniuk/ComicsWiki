//
//  AuthManager.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 20.02.2026.
//

import Foundation
import ComposableArchitecture

struct AuthManager {
    @Dependency(\.defaultAppStorage) var appStorage
    
    private let key = "auth_token"
    
    func saveToken(_ token: String) {
        appStorage.set(token, forKey: key)
    }
    
    func getToken() -> String? {
        appStorage.string(forKey: key)
    }
    
    func clearToken() {
        appStorage.removeObject(forKey: key)
    }
    
    var isAuthorized: Bool {
        getToken() != nil
    }
}

// MARK: Dependency
extension AuthManager: DependencyKey {
    static var liveValue = AuthManager()
    
    static let testValue = AuthManager()
}

extension DependencyValues {
    var authManager: AuthManager {
        get { self[AuthManager.self] }
        set { self[AuthManager.self] = newValue }
    }
}
