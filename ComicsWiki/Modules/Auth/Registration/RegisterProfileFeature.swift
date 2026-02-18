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

    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
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
            }
        }
    }
}
