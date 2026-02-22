//
//  HomeFeature.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 20.02.2026.
//

import Foundation
import ComposableArchitecture

@Reducer
struct HomeFeature {
    @Dependency(\.authManager) var authManager
    
    struct State {}
    
    enum Action: Equatable {
        case logoutTapped
    }
    
    var body: some Reducer <State, Action> {
        Reduce { state, action in
            switch action {
            case .logoutTapped:
                return .none
            }
        }
    }
}
