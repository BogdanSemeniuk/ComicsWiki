//
//  RegisterHeaderView.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 19.02.2026.
//

import SwiftUI

struct RegisterHeaderView: View {
    var title: LocalizedStringResource
    var description: LocalizedStringResource
    
    var body: some View {
        Text(title)
            .font(.system(size: 28, weight: .semibold))
            .foregroundStyle(.textPrimary)
        Text(description)
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(.accentYellow)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    RegisterHeaderView(
        title: .Registration.profileTitle,
        description: .Registration.profileDescription
    )
}
