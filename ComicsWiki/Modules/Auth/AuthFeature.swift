//
//  AuthFeature.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 10.02.2026.
//

import ComposableArchitecture

@Reducer
struct AuthFeature {
    @ObservableState
    struct State {
        var email = ""
        var password = ""
        var isButtonDisabled = true
    }
    
    enum Action {
        case signInTapped
        case emailChanged(String)
        case passwordChanged(String)
        case inputChanged
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .signInTapped:
                return .none
            case .emailChanged(let text):
                state.email = text
                return .send(.inputChanged)
            case .passwordChanged(let text):
                state.password = text
                return .send(.inputChanged)
            case .inputChanged:
                state.isButtonDisabled = state.email.isEmpty || state.password.isEmpty
                return .none
            }
        }
    }
}
