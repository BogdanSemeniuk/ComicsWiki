//
//  ValidationErrorMessage.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 19.02.2026.
//

import SwiftUI

struct ValidationErrorMessage: View {
    var message: String?
    
    var body: some View {
        Text(message ?? "")
            .font(.system(size: 14))
            .frame(height: 36)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(Color(.textFieldError))
    }
}

#Preview {
    ValidationErrorMessage(message: "")
}
