//
//  RoundedButton.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 09.02.2026.
//

import SwiftUI

struct RoundedButton: View {
    var label: String
    var disabled = false
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .frame(height: 56)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundStyle(.textPrimary.opacity(disabled ? 0.5 : 1))
                .font(.system(size: 17, weight: .semibold))
                .background(
                    .brandPrimary.opacity(disabled ? 0.5 : 1),
                    in: RoundedRectangle(cornerRadius: 14)
                )
        }
        .disabled(disabled)
    }
}

#Preview {
    RoundedButton(label: "Log In", disabled: false, action: {})
}
