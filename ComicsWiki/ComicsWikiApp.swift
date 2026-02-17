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
            RegistrationView()
//            SignInView(
//                store: Store(initialState: SignInFeature.State()) {
//                    SignInFeature()
//                }
//            )
        }
    }
}
