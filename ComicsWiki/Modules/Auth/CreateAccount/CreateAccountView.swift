//
//  CreateAccountView.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 18.02.2026.
//

import SwiftUI
import ComposableArchitecture

struct CreateAccountView: View {
    enum FocusedField {
        case email, password, confirm
    }

    @Bindable var store: StoreOf<CreateAccountFeature>
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        VStack(spacing: 24) {
            RegisterHeaderView(
                title: .Registration.accountTitle,
                description: .Registration.accountDescription
            )
            inputs
            Spacer()
            RoundedButton(
                label: String(localized: .Registration.createAccountButton),
                disabled: store.isButtonDisabled,
                action: { store.send(.createAccountTapped) }
            )
        }
        .padding(.horizontal, 16)
        .background(Color(.background))
    }

    private var inputs: some View {
        VStack(spacing: 0) {
            AppTextField(
                text: $store.email,
                placeholder: String(localized: .Common.emailFieldPlaceholder),
                isFocused: focusedField == .email,
                hasError: store.emailValidationError != nil,
                keyboardType: .emailAddress
            )
            .focused($focusedField, equals: .email)
            .onSubmit { focusedField = .password }
            
            ValidationErrorMessage(message: store.emailValidationError)
            
            AppSecureTextField(
                text: $store.password,
                placeholder: String(localized: .Common.passwordFieldPlaceholder),
                isFocused: focusedField == .password,
                hasError: store.passwordValidationError != nil
            )
            .focused($focusedField, equals: .password)
            .onSubmit { focusedField = .confirm }
            
            ValidationErrorMessage(message: store.passwordValidationError)
            
            AppSecureTextField(
                text: $store.confirmPassword,
                placeholder: String(localized: .Common.confirmPasswordFieldPlaceholder),
                isFocused: focusedField == .confirm,
                hasError: store.confirmPasswordValidationError != nil
            )
            .focused($focusedField, equals: .confirm)
            .onSubmit { focusedField = nil }
            
            ValidationErrorMessage(message: store.confirmPasswordValidationError)
        }
    }
}

#Preview {
    CreateAccountView(
        store: Store(initialState: CreateAccountFeature.State()) {
            CreateAccountFeature()
        }
    )
}
