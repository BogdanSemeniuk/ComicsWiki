//
//  SignInFeature.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 10.02.2026.
//

import ComposableArchitecture
import Foundation

@Reducer
struct SignInFeature {
    @Dependency(\.inputValidator) var inputValidator
    @Dependency(\.liveHTTPClient) var liveHTTPClient
    
    @ObservableState
    struct State: Equatable {
        var email = ""
        var password = ""
        var emailValidationError: String?
        var passwordValidationError: String?
        var isButtonDisabled = true
        @Presents var registerProfile: RegisterProfileFeature.State?
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case registerProfile(PresentationAction<RegisterProfileFeature.Action>)
        case signInTapped
        case createOneTapped
        case sessionResponse(Result<Session, any Error>)
        case delegate(Delegate)
        
        enum Delegate: Equatable {
            case fetchedToken(String)
        }
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .signInTapped:
                do {
                    try inputValidator.validateEmail(state.email)
                    try inputValidator.validatePassword(state.password)
                    return .run { [state = state] send in
                        await send(.sessionResponse(Result {
                            try await self.liveHTTPClient.send(
                                APIEndpoint.login(email: state.email, password: state.password), as: Session.self
                            )
                        }))
                    }
                } catch {
                    guard let error = error as? ValidationError else { return .none }
                    if error == .invalidEmail {
                        state.emailValidationError = error.localizedDescription
                    } else {
                        state.passwordValidationError = error.localizedDescription
                    }
                }
                return .none
            case .sessionResponse(.failure):
                return .none
                
            case let .sessionResponse(.success(response)):
                return .send(.delegate(.fetchedToken(response.token)))
                
            case .registerProfile(.presented(.delegate(.fetchedToken(let token)))):
                state.registerProfile = nil
                return .send(.delegate(.fetchedToken(token)))
            case .registerProfile:
                return .none
            case .delegate:
                return .none
            case .createOneTapped:
                state.registerProfile = RegisterProfileFeature.State()
                return .none
            case .binding:
                state.emailValidationError = nil
                state.passwordValidationError = nil
                state.isButtonDisabled = state.email.isEmpty || state.password.isEmpty
                return .none
            }
        }
        .ifLet(\.$registerProfile, action: \.registerProfile) {
            RegisterProfileFeature()
        }
    }
}
