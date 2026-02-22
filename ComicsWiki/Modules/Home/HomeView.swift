//
//  HomeView.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 20.02.2026.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    var store: StoreOf<HomeFeature>
    
    var body: some View {
        Button("logout") {
            store.send(.logoutTapped)
        }
    }
}
