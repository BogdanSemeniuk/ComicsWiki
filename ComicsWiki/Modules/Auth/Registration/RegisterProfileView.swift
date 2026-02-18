//
//  RegisterProfileView.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 17.02.2026.
//

import SwiftUI
import ComposableArchitecture

struct RegisterProfileView: View {
    enum FocusedField {
        case nickName, gender
    }
    @Bindable var store: StoreOf<RegisterProfileFeature>
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        VStack(spacing: 20) {
            Text(.Registration.profileTitle)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(.textPrimary)
            Text(.Registration.profileDescription)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.accentYellow)
                .frame(maxWidth: .infinity, alignment: .leading)
            GeometryReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {
                        nickNameView
                        genderView
                        genderInputView
                        birthdayView
                        Spacer()
                        RoundedButton(
                            label: String(localized: .Registration.continueButton),
                            disabled: store.isContionueButtonDisabled,
                            action: {
                                
                            }
                        )
                        .padding(.bottom, 8)
                    }
                    .frame(minHeight: proxy.size.height)
                }
                .animation(.easeOut, value: store.gender)
            }
        }
        .padding(.horizontal, 16)
        .background(Color(.background))
    }
    
    private var nickNameView: some View {
        section(withLabel: .Registration.nickLabel) {
            AppTextField(
                text: $store.nickName,
                placeholder: String(localized: .Registration.nickFieldPlaceholder),
                isFocused: focusedField == .nickName
            )
            .focused($focusedField, equals: .nickName)
            .onSubmit {
                focusedField = nil
            }
        }
    }
    
    private var genderView: some View {
        section(withLabel: .Registration.genderLabel) {
            Picker("", selection: $store.gender) {
                ForEach(Gender.allCases, id: \.rawValue) { option in
                    Text(option.rawValue.capitalized)
                        .tag(option)
                }
            }
            .pickerStyle(.segmented)
        }
    }
    
    @ViewBuilder
    private var genderInputView: some View {
        if store.gender == .other {
            section(withLabel: .Registration.genderFieldLabel) {
                AppTextField(
                    text: $store.genderDescription,
                    placeholder: String(localized: .Registration.genderFieldPlaceholder),
                    isFocused: focusedField == .gender
                )
                .focused($focusedField, equals: .gender)
                .onSubmit {
                    focusedField = nil
                }
            }
            .transition(.move(edge: .top).combined(with: .opacity))
        }
    }
    
    private var birthdayView: some View {
        HStack(spacing: 16) {
            textLabel(.Registration.birthdayLabel)
            Button {
                
            } label: {
                HStack {
                    Image(sf: .calendar)
                    Text(.Registration.addBirthdayButton)
                }
                .padding(4)
                .padding(.horizontal, 12)
                .background(.white, in: .capsule)
                .foregroundStyle(.primaryBlue)
            }
        }
    }
    
    private func section(
        withLabel stringResource: LocalizedStringResource,
        content: () -> some View
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            textLabel(stringResource)
            content()
        }
    }
    
    private func textLabel(_ resource: LocalizedStringResource) -> some View {
        Text(resource)
            .font(.system(size: 16))
            .foregroundStyle(.textSecondary)
    }
}

#Preview {
    RegisterProfileView(
        store: .init(initialState: .init(), reducer: {
            RegisterProfileFeature()
        })
    )
}
