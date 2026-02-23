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
        var isAuthorized: Bool?
        var signIn: SignInFeature.State?
        var home: HomeFeature.State?
    }
    
    enum Action {
        case onFirstAppear
        case signIn(SignInFeature.Action)
        case home(HomeFeature.Action)
    }
    
    var body: some Reducer <State, Action> {
        Reduce { state, action in
            switch action {
            case .onFirstAppear:
                update(state: &state)
                return .none
            case .signIn(.delegate(.fetchedToken(let token))):
                authManager.saveToken(token)
                update(state: &state)
                return .none
            case .home(.delegate(.logout)):
                authManager.clearToken()
                update(state: &state)
                return .none
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
    
    private func update(state: inout State) {
        let isAuthorized = authManager.isAuthorized
        if isAuthorized {
            state.home = HomeFeature.State()
            state.signIn = nil
        } else {
            state.signIn = SignInFeature.State()
            state.home = nil
        }
        state.isAuthorized = authManager.isAuthorized
    }
}
