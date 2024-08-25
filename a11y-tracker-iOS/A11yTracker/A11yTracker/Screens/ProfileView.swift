//
//  ProfileView.swift
//  A11yTracker
//
//  Created by Dani on 25/08/2024.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    //TODO: Move this out
    private var isUserNameValid: Bool {
        let nonAlphanumericCharacters = CharacterSet.alphanumerics.inverted
        return !username.isEmpty && (username.rangeOfCharacter(from: nonAlphanumericCharacters) == nil)
    }
    
    private var isPasswordValid: Bool {
        return password.count >= 8 && password.count <= 16
    }
    
    var body: some View {
        NavigationStack {
            //TODO: Refactor this into its own Login View
            Form {
                Section {
                    Text("Username:")
                        .accessibilityHidden(true)
                    TextField("JohnAppleSeed", text: $username)
                        .accessibilityLabel("Username")
                    Text("Password:")
                        .accessibilityHidden(true)
                    SecureField("***************", text: $password)
                        .accessibilityLabel("Password")
                    Button("Login") {
                        print("Login")
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
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
        .modelContainer(for: Item.self, inMemory: true)
}
