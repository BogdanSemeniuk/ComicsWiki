//
//  CreateAccountFeature.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 18.02.2026.
//

import Foundation
import ComposableArchitecture

@Reducer
struct CreateAccountFeature {
    @Dependency(\.inputValidator) var inputValidator
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    struct State: Equatable {
        var email = ""
        var password = ""
        var confirmPassword = ""

        var emailValidationError: String?
        var passwordValidationError: String?
        var confirmPasswordValidationError: String?

        var isButtonDisabled: Bool {
            return email.isEmpty || password.isEmpty || confirmPassword.isEmpty
        }
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case createAccountTapped
        case closeTapped
    }

    var body: some Reducer <State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .closeTapped:
                return .run { _ in await self.dismiss() }
            case .binding:
                state.emailValidationError = nil
                state.passwordValidationError = nil
                state.confirmPasswordValidationError = nil
                return .none
            case .createAccountTapped:
                do {
                    try inputValidator.validateEmail(state.email)
                    try inputValidator.validatePassword(state.password)
                    if state.password != state.confirmPassword {
                        throw ValidationError.passwordsNotMatch
                    }
                } catch {
                    guard let error = error as? ValidationError else { return .none }
                    if error == .invalidEmail {
                        state.emailValidationError = error.localizedDescription
                    } else if error == .passwordsNotMatch {
                        state.confirmPasswordValidationError = error.localizedDescription
                    } else {
                        state.passwordValidationError = error.localizedDescription
                    }
                }
                return .none
            }
        }
    }
}
