//
//  RegisterView.swift
//  A11yTracker
//
//  Created by Dani on 26/08/2024.
//

import Foundation

import Foundation
import SwiftUI

struct RegisterView: View {
    @EnvironmentObject private var dataStore: A11yTrackerDataStore
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    //TODO: Better capture view state
    @State private var registering: Bool = false
    @State private var registered: Bool = false
    
    var body: some View {
        Form {
            Text("Username:")
                .accessibilityHidden(true)
            TextField("johnappleseed", text: $username)
                .textContentType(.username)
                .textInputAutocapitalization(.never)
                .accessibilityLabel("Username")
            Text("Password:")
                .accessibilityHidden(true)
            SecureField("***************", text: $password)
                .textContentType(.password)
                .accessibilityLabel("Password")
            Text("Confirm password:")
                .accessibilityHidden(true)
            SecureField("***************", text: $password)
                .textContentType(.password)
                .accessibilityLabel("Confirm password")
            
            if registering {
                ProgressView()
                    .accessibilityLabel("Registering...")
            } else {
                Button("Register") {
                    Task {
                        await register()
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(!(UserUtils.validate(username: username) && UserUtils.validate(password: password, confirmPassword: confirmPassword)))
            }
        }
    }
    
    private func register() async {
        registering = true
        
        do {
            let response = try await dataStore.login(username: username, password: password)
            registered = true
            registering = false
        } catch {
            //TODO: Handle error
            registering = false
        }
    }
}

#Preview {
    RegisterView()
        .environmentObject(A11yTrackerDataStore())
}
