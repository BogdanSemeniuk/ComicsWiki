//
//  AppFeature.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 20.02.2026.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AppFeature {
    @Dependency(\.authManager) var authManager
    
    @ObservableState
    struct State {
        var isAuthorized = false
    }
    
    enum Action: Equatable {
        case onAppear
    }
    
    var body: some Reducer <State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.isAuthorized = authManager.isAuthorized
                return .none
            }
        }
    }
}
