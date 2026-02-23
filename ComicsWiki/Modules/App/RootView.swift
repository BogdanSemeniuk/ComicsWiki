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
        VStack {
            if let isAuthorized = store.isAuthorized {
                if isAuthorized {
                    if let homeStore = store.scope(state: \.home, action: \.home) {
                        NavigationStack {
                            HomeView(store: homeStore)
                                .transition(.opacity)
                        }
                    }
                } else {
                    if let signInStore = store.scope(state: \.signIn, action: \.signIn) {
                        NavigationStack {
                            SignInView(store: signInStore)
                                .transition(.opacity)
                        }
                    }
                }
            }
        }
        .onFirstAppear {
            store.send(.onFirstAppear)
        }
    }
}

#Preview {
    RootView(store: .init(initialState: AppFeature.State()) {
        AppFeature()
    })
}
