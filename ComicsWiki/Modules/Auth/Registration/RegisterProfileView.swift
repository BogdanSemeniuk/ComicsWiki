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
    @Namespace private var presentation
    private let transitionId = "transitionId"
    
    var body: some View {
        VStack(spacing: 20) {
            RegisterHeaderView(
                title: .Registration.profileTitle,
                description: .Registration.profileDescription
            )
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
                            disabled: store.isContinueButtonDisabled,
                            action: {
                                store.send(.continueTapped)
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
        .sheet(isPresented: $store.isDatePickerShown) {
            datePicker()
                .presentationDetents([.fraction(0.7)])
                .navigationTransition(.zoom(sourceID: transitionId, in: presentation))
        }
        .fullScreenCover(
            item: $store.scope(state: \.createAccount, action: \.createAccount)
        ) { store in
            CreateAccountView(store: store)
        }
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
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 16) {
                textLabel(.Registration.birthdayLabel)
                Button {
                    store.isDatePickerShown = true
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
                .matchedTransitionSource(id: transitionId, in: presentation)
            }
            if store.birthdayWasSet {
                HStack(spacing: 16) {
                    Text(store.dateOfBirth.string(.long))
                        .font(.system(size: 16))
                    Button("", sf: .xmarkCircleFill) {
                        store.birthdayWasSet = false
                    }
                }
                .foregroundStyle(.textPrimary)
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
    
    @ViewBuilder
    func datePicker() -> some View {
        NavigationStack {
            DatePicker("", selection: $store.dateOfBirth, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .navigationTitle(Text(.Registration.birthdayPickerTitle))
        }
    }
}

#Preview {
    RegisterProfileView(
        store: .init(initialState: .init(), reducer: {
            RegisterProfileFeature()
        })
    )
}
