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
    private let store = Store(initialState: AppFeature.State()) {
        AppFeature()
    }
    
    init() {
        setupSegmentedControlAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView(store: store)
            }
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
