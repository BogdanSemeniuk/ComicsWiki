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
    init() {
        setupSegmentedControlAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            RegisterProfileView(
                store: Store(initialState: RegisterProfileFeature.State(), reducer: {
                    RegisterProfileFeature()
                })
            )
//            SignInView(
//                store: Store(initialState: SignInFeature.State()) {
//                    SignInFeature()
//                }
//            )
        }
    }
    
    private func setupSegmentedControlAppearance() {
        let segmentedControlFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        UISegmentedControl.appearance().setTitleTextAttributes(
            [
                .foregroundColor: UIColor.textPrimary,
                .font: segmentedControlFont
            ],
            for: .selected
        )
        UISegmentedControl.appearance().setTitleTextAttributes(
            [
                .foregroundColor: UIColor.textSecondary,
                .font: segmentedControlFont
            ],
            for: .normal
        )
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.primaryBlue
    }
}
