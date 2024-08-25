//
//  ProfileView.swift
//  A11yTracker
//
//  Created by Dani on 25/08/2024.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            Text("Your profile goes here")
                .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
        .modelContainer(for: Item.self, inMemory: true)
}
