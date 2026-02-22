//
//  SignInView.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 07.02.2026.
//

import SwiftUI
import ComposableArchitecture

struct SignInView: View {
    enum FocusedField {
        case email, password
    }
    @Bindable var store: StoreOf<SignInFeature>
    @FocusState private var focusedField: FocusedField?
    
    private var cardShape: some Shape {
        RoundedRectangle(cornerRadius: 16)
    }
    
    var body: some View {
        VStack(spacing: 24) {
            header
            Spacer()
            card
            Spacer()
            registrationPrompt
        }
        .background(Color(.background))
        .navigationDestination(
            item: $store.scope(state: \.registerProfile, action: \.registerProfile)
        ) { store in
            RegisterProfileView(store: store)
        }
    }
    
    @ViewBuilder
    private var header: some View {
        VStack(spacing: 0) {
            Image(.comicswikiLogo)
                .resizable()
                .scaledToFill()
                .frame(width: 180, height: 180)
            Text(.SignIn.title)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(.textPrimary)
            Text(.SignIn.description)
                .font(.system(size: 14))
                .foregroundStyle(.textSecondary)
                .padding(.top, 8)
        }
    }
    
    private var card: some View {
        VStack(spacing: 0) {
            AppTextField(
                text: $store.email,
                placeholder: String(localized: .Common.emailFieldPlaceholder),
                isFocused: focusedField == .email,
                hasError: store.emailValidationError != nil,
                keyboardType: .emailAddress
            )
            .focused($focusedField, equals: .email)
            .onSubmit {
                focusedField = .password
            }
            ValidationErrorMessage(message: store.emailValidationError)
            AppSecureTextField(
                text: $store.password,
                placeholder: String(localized: .Common.passwordFieldPlaceholder),
                isFocused: focusedField == .password,
                hasError: store.passwordValidationError != nil
            )
            .focused($focusedField, equals: .password)
            .onSubmit {
                focusedField = nil
            }
            ValidationErrorMessage(message: store.passwordValidationError)
            RoundedButton(
                label: String(localized: .SignIn.loginButton),
                disabled: store.isButtonDisabled,
                action: {
                    store.send(.signInTapped)
                }
            )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
        .background(.elevatedSurface, in: cardShape)
        .overlay {
            cardShape
                .stroke(.border)
        }
    }
    
    private var registrationPrompt: some View {
        HStack(spacing: 0) {
            Text(.SignIn.createAccountDescription)
                .foregroundStyle(.textSecondary)
            Button {
                store.send(.createOneTapped)
            } label: {
                Text(.SignIn.createButton)
                    .fontWeight(.semibold)
                    .foregroundStyle(.accentYellow)
                    .underline()
                    .padding(8)
            }
        }
        .font(.system(size: 14))
    }
}

#Preview {
    SignInView(
        store: Store(initialState: SignInFeature.State()) {
            SignInFeature()
        }
    )
}
