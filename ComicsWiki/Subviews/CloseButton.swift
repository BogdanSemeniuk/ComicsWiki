//
//  CloseButton.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 19.02.2026.
//

import SwiftUI

struct CloseButton: View {
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Circle()
                    .stroke(Color(.textSecondary))
                    .shadow(color: .gray, radius: 3, x: -2, y: 2)
                Image(sf: .xmark)
                    .resizable()
                    .padding(8)
                    .foregroundStyle(Color(.textPrimary))
            }
            .frame(width: 30, height: 30)
        }
    }
}

#Preview {
    CloseButton(action: {})
}
