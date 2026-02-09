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
    var inputColor = Color(.textPrimary)
    var borderColor = Color(.border)
    var focusedBorderColor = Color(.textFieldBorderFocused)
    var errorBorderColor = Color(.textFieldError)
    @FocusState private var isFocused: Bool
    private var shape: some Shape {
        RoundedRectangle(cornerRadius: 12)
    }
    
    var body: some View {
        TextField(
            "",
            text: $text,
            prompt: Text(placeholder).foregroundColor(.textSecondary)
        )
        .padding(10)
        .overlay {
            shape
                .stroke(borderStrokeColor)
        }
        .background(.textFieldBackground, in: shape)
        .foregroundStyle(.textPrimary)
        .focused($isFocused)
        .onTapGesture {
            isFocused = true
        }
    }
    
    private var borderStrokeColor: Color {
        isFocused ? focusedBorderColor : borderColor
    }
}



#Preview {
    AppTextField(
        text: .constant(""),
        placeholder: String(localized: .SignIn.emailFieldPlaceholder)
    )
}


