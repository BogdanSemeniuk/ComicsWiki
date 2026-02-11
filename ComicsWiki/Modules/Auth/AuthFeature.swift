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
    struct State: Equatable {
        var email = ""
        var password = ""
        var isButtonDisabled = true
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case signInTapped
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .signInTapped:
                return .none
            case .binding:
                state.isButtonDisabled = state.email.isEmpty || state.password.isEmpty
                return .none
            }
        }
    }
}
