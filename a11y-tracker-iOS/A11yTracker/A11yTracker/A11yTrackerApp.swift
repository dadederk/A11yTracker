//
//  A11yTrackerApp.swift
//  A11yTracker
//
//  Created by Daniel Devesa Derksen-Staats on 21/08/2024.
//

import SwiftUI
import SwiftData

@main
struct A11yTrackerApp: App {
    @StateObject private var dataStore = A11yTrackerDataStore()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Issue.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataStore)
        }
        .modelContainer(sharedModelContainer)
    }
}
