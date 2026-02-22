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
            if store.isAuthorized {
                if let homeStore = store.scope(state: \.home, action: \.home) {
                    HomeView(store: homeStore)
                }
            } else {
                if let signInStore = store.scope(state: \.signIn, action: \.signIn) {
                    SignInView(store: signInStore)
                }
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
