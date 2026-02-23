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
    struct State {}
    
    enum Action: Equatable {
        case logoutTapped
        case delegate(Delegate)
        
        enum Delegate: Equatable {
            case logout
        }
    }
    
    var body: some Reducer <State, Action> {
        Reduce { state, action in
            switch action {
            case .logoutTapped:
                return .send(.delegate(.logout))
            case .delegate:
                return .none
            }
        }
    }
}
