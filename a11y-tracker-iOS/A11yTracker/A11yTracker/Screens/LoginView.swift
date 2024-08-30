//
//  LoginView.swift
//  A11yTracker
//
//  Created by Dani on 26/08/2024.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var dataStore: A11yTrackerDataStore
    @State private var username: String = ""
    @State private var password: String = ""
    //TODO: Better capture view state
    @State private var loggingIn: Bool = false
    @State private var loggedIn: Bool = false
    @State private var errorMessage: String? = nil
    
    var body: some View {
        if loggedIn {
            Text("Welcome")
        } else {
            Form {
                Section {
                    Text("Username:")
                        .accessibilityHidden(true)
                    TextField("johnappleseed", text: $username)
                        .textContentType(.username)
                        .textInputAutocapitalization(.never)
                        .accessibilityLabel("Username")
                        .onChange(of: username) { oldValue, newValue in
                            errorMessage = nil
                        }
                    Text("Password:")
                        .accessibilityHidden(true)
                    SecureField("***************", text: $password)
                        .textContentType(.password)
                        .accessibilityLabel("Password")
                        .onChange(of: username) { oldValue, newValue in
                            errorMessage = nil
                        }
                    
                    if loggingIn {
                        ProgressView()
                            .accessibilityLabel("Logging in...")
                    } else {
                        Button("Login") {
                            Task {
                                await login()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(!(UserUtils.validate(username: username) && UserUtils.validate(password: password)))
                    }
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                    }
                } header: {
                    Text("Login")
                }
                Section {
                    NavigationLink {
                        RegisterView()
                    } label: {
                        Text("Register")
                    }
                    .buttonStyle(.bordered)
                } header: {
                    Text("Don't have an account yet?")
                }
            }
        }
    }
    
    private func login() async {
        loggingIn = true
        
        do {
            //TODO: Save token securely in keychain
            let response = try await dataStore.login(username: username, password: password)
            loggedIn = true
            loggingIn = false
        } catch {
            //TODO: Handle error
            errorMessage = error.localizedDescription
            loggingIn = false
        }
    }
    
    //TODO: Call this when the error is triggered
    private func announceError(_ message: String) {
        guard let errorMessage = errorMessage else { return }
        AccessibilityNotification.Announcement(errorMessage)
    }
}

#Preview {
    LoginView()
        .environmentObject(A11yTrackerDataStore())
}
