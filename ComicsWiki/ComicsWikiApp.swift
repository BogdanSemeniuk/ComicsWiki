//
//  ComicsWikiApp.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 07.02.2026.
//

import SwiftUI
import ComposableArchitecture

@main
struct ComicsWikiApp: App {
    var body: some Scene {
        WindowGroup {
            SignInView(
                store: Store(initialState: AuthFeature.State()) {
                    AuthFeature()
                }
            )
        }
    }
}
