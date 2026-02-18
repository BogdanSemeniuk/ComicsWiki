//
//  Button+SystemImage.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 18.02.2026.
//

import SwiftUI

extension Button where Label == SwiftUI.Label<Text, Image> {
    init(_ titleKey: LocalizedStringKey, sf symbol: SFSymbol, action: @escaping @MainActor () -> Void) {
        self.init(titleKey, systemImage: symbol.rawValue, action: action)
    }
}
