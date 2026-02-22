//
//  RegisterProfileFeature.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 17.02.2026.
//

import Foundation
import ComposableArchitecture

@Reducer
struct RegisterProfileFeature {
    @ObservableState
    struct State: Equatable {
        var nickName = ""
        var gender: Gender = .female
        var genderDescription = ""
        var dateOfBirth = Date()
        var birthdayWasSet = false
        var email = ""
        var isDatePickerShown = false
        var isContinueButtonDisabled: Bool {
            if gender == .other {
                return genderDescription.isEmpty || nickName.isEmpty
            }
            return nickName.isEmpty
        }
        
        @Presents var createAccount: CreateAccountFeature.State?
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case createAccount(PresentationAction<CreateAccountFeature.Action>)
        case continueTapped
        case delegate(Delegate)
        
        enum Delegate: Equatable {
            case fetchedToken(String)
        }
    }
    
    var body: some Reducer <State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.dateOfBirth):
                state.birthdayWasSet = true
                return .none
            case .binding:
                return .none
            case .continueTapped:
                state.createAccount = CreateAccountFeature.State()
                return .none
            case .createAccount(.presented(.delegate(.fetchedToken(let token)))):
                state.createAccount = nil
                return .send(.delegate(.fetchedToken(token)))
            case .createAccount:
                return .none
            case .delegate:
                return .none
            }
        }
        .ifLet(\.$createAccount, action: \.createAccount) {
            CreateAccountFeature()
        }
    }
}
