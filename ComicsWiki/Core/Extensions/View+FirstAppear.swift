//
//  View+FirstAppear.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 23.02.2026.
//

import SwiftUI

extension View {
    func onFirstAppear(_ action: @escaping () -> ()) -> some View {
        modifier(FirstAppear(action: action))
    }
}

struct FirstAppear: ViewModifier {
    let action: () -> ()
    @State private var hasAppeared = false
    
    func body(content: Content) -> some View {
        content.onAppear {
            guard !hasAppeared else { return }
            hasAppeared = true
            action()
        }
    }
}
