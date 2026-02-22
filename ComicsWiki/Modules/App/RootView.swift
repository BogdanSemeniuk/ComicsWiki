//
//  RootView.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 20.02.2026.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    let store: StoreOf<AppFeature>
    
    var body: some View {
        Group {
            if !store.isAuthorized {
                HomeView(store: .init(initialState: HomeFeature.State()) {
                    HomeFeature()
                })
            } else {
                SignInView(store: .init(initialState: SignInFeature.State()) {
                    SignInFeature()
                })
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}

#Preview {
    RootView(store: .init(initialState: AppFeature.State()) {
        AppFeature()
    })
}
