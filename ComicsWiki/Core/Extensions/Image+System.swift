//
//  Image+System.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 10.02.2026.
//

import SwiftUI

extension Image {
    init(sf symbol: SFSymbol) {
        self = Image(systemName: symbol.rawValue)
    }
    
    enum SFSymbol: String {
        case eye
        case calendar
        case eyeSlash = "eye.slash"
    }
}
