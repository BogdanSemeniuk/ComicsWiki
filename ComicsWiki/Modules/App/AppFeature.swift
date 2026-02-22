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
        var signIn: SignInFeature.State?
        var home: HomeFeature.State?
    }
    
    enum Action: Equatable {
        case onAppear
        case signIn(SignInFeature.Action)
        case home(HomeFeature.Action)
    }
    
    var body: some Reducer <State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                let isAuthorized = authManager.isAuthorized
                if isAuthorized {
                    state.home = HomeFeature.State()
                } else {
                    state.signIn = SignInFeature.State()
                }
                state.isAuthorized = authManager.isAuthorized
                return .none
            case .signIn(.delegate(.fetchedToken(let token))):
                authManager.saveToken(token)
                state.signIn = nil
                return .send(.onAppear)
            case .home(.delegate(.logout)):
                authManager.clearToken()
                state.home = nil
                return .send(.onAppear)
            case .signIn, .home:
                return .none
            }
        }
        .ifLet(\.signIn, action: \.signIn) {
            SignInFeature()
        }
        .ifLet(\.home, action: \.home) {
            HomeFeature()
        }
    }
}
