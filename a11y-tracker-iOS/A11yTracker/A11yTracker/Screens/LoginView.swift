//
//  LoginView.swift
//  A11yTracker
//
//  Created by Dani on 26/08/2024.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var dataStore:A11yTrackerDataStore
    @State private var username: String = ""
    @State private var password: String = ""
    
    //TODO: Move validation logic out
    private var isUserNameValid: Bool {
        let nonAlphanumericCharacters = CharacterSet.alphanumerics.inverted
        return !username.isEmpty && (username.rangeOfCharacter(from: nonAlphanumericCharacters) == nil)
    }
    
    private var isPasswordValid: Bool {
        return password.count >= 8 && password.count <= 16
    }
    
    var body: some View {
        Form {
            Section {
                Text("Username:")
                    .accessibilityHidden(true)
                TextField("JohnAppleSeed", text: $username)
                    .textContentType(.username)
                    .textInputAutocapitalization(.never)
                    .accessibilityLabel("Username")
                Text("Password:")
                    .accessibilityHidden(true)
                SecureField("***************", text: $password)
                    .accessibilityLabel("Password")
                Button("Login") {
                    Task {
                        await login()
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(!(isUserNameValid && isPasswordValid))
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
    
    private func login() async {
        do {
            print("Login for \(username) and \(password)")
            let token = try await dataStore.login(username: username, password: password)
            print("Token received: \(String(describing: token))")
        } catch {
            print("Error login in")
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(A11yTrackerDataStore())
}
