//
//  AppTextField.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 09.02.2026.
//

import SwiftUI

struct AppTextField: View {
    @Binding var text: String
    var placeholder = ""
    var isFocused = false
    var hasError = false
    var inputColor = Color(.textPrimary)
    var borderColor = Color(.border)
    var focusedBorderColor = Color(.textFieldBorderFocused)
    var errorBorderColor = Color(.textFieldError)
    var keyboardType: UIKeyboardType = .default
    var autocorrectionDisabled = true
    
    var body: some View {
        TextField(
            "",
            text: $text,
            prompt: Text(placeholder).foregroundColor(.textSecondary)
        )
        .textFieldStyle(
            AppTextFieldStyle(
                isFocused: isFocused,
                hasError: hasError,
                inputColor: inputColor,
                borderColor: borderColor,
                focusedBorderColor: focusedBorderColor,
                errorBorderColor: errorBorderColor,
                keyboardType: keyboardType,
                autocorrectionDisabled: autocorrectionDisabled
            )
        )
    }
}

#Preview {
    AppTextField(
        text: .constant(""),
        placeholder: String(localized: .SignIn.emailFieldPlaceholder)
    )
}
