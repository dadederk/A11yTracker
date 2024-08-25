//
//  ContentView.swift
//  A11yTracker
//
//  Created by Daniel Devesa Derksen-Staats on 21/08/2024.
//

import SwiftUI

enum Tabs: Equatable, Hashable, Identifiable {
    var id: Self { return self }
    
    case issues
    case search
    case profile
}

struct ContentView: View {
    @State private var selectedTab: Tabs = .issues
    
    var body: some View {
        TabView(selection: $selectedTab) {
            IssuesView()
                .tabItem {
                    Label("Issues", systemImage: "ant")
                }
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass.circle")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
