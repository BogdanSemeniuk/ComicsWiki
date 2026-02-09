//
//  SignInView.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 07.02.2026.
//

import SwiftUI

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    
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
            AppTextField(text: $email, placeholder: String(localized: .SignIn.emailFieldPlaceholder))
                .padding(.bottom, 16)
            AppTextField(text: $password, placeholder: String(localized: .SignIn.passwordFieldPlaceholder))
                .padding(.bottom, 22)
            RoundedButton(
                label: String(localized: .SignIn.loginButton),
                disabled: false,
                action: {}
            )
        }
        .padding(16)
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
                print("Create one")
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
    SignInView()
}
