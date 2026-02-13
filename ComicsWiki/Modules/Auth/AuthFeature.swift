//
//  AuthFeature.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 10.02.2026.
//

import ComposableArchitecture
import Foundation

@Reducer
struct AuthFeature {
    @Dependency(\.inputValidator) var inputValidator
    
    @ObservableState
    struct State: Equatable {
        var email = ""
        var password = ""
        var emailValidationError: String?
        var passwordValidationError: String?
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
                do {
                    try inputValidator.validateEmail(state.email)
                    try inputValidator.validatePassword(state.password)
                } catch {
                    guard let error = error as? ValidationError else { return .none }
                    if error == .invalidEmail {
                        state.emailValidationError = error.localizedDescription
                    } else {
                        state.passwordValidationError = error.localizedDescription
                    }
                }
                return .none
            case .binding:
                state.emailValidationError = nil
                state.passwordValidationError = nil
                state.isButtonDisabled = state.email.isEmpty || state.password.isEmpty
                return .none
            }
        }
    }
}
