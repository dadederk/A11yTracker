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
    var body: some View {
        Text("Registration form goes here")
        
    }
}

#Preview {
    RegisterView()
        .modelContainer(for: Item.self, inMemory: true)
}
