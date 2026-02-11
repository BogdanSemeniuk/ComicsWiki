//
//  AppTextFieldStyle.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 10.02.2026.
//

import SwiftUI

struct AppTextFieldStyle: TextFieldStyle {
    var isFocused: Bool
    var hasError: Bool
    var inputColor: Color
    var borderColor: Color
    var focusedBorderColor: Color
    var errorBorderColor: Color
    var keyboardType: UIKeyboardType
    var autocorrectionDisabled: Bool
    var trailingInputInset: CGFloat = 0
    private var shape: some Shape {
        RoundedRectangle(cornerRadius: 12)
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(autocorrectionDisabled)
            .keyboardType(keyboardType)
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .padding(.trailing, trailingInputInset)
            .overlay {
                shape
                    .stroke(borderStrokeColor)
            }
            .background(.textFieldBackground, in: shape)
            .foregroundStyle(inputColor)
    }
    
    private var borderStrokeColor: Color {
        if hasError { return errorBorderColor }
        return isFocused ? focusedBorderColor : borderColor
    }
}
