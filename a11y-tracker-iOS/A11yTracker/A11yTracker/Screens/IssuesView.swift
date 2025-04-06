//
//  IssuesView.swift
//  A11yTracker
//
//  Created by Dani on 25/08/2024.
//

import Foundation
import SwiftData
import SwiftUI

struct IssuesView: View {
    @Environment(\.accessibilityShowButtonShapes) private var buttonShapesEnabled
    @Environment(\.modelContext) private var modelContext
    @Query private var issues: [Issue]
    @State private var showIssueComposer: Bool = false
    @State private var selectedList = 0
    
    var body: some View {
        NavigationSplitView {
            VStack {
                Picker("List sorted by", selection: $selectedList) {
                    Text("Most recent").tag(0)
                    Text("Most voted").tag(1)
                }
                .pickerStyle(.segmented)
                .padding()
                
                List {
                    ForEach(issues) { issue in
                        NavigationLink {
                            
                        } label: {
                            
                        }
                    }
                }
#if os(macOS)
                .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
                .toolbar {
                    ToolbarItem {
                        Button(action: {
                            showIssueComposer.toggle()
                        }, label: {
                            Label("Compose Issue", systemImage: "square.and.pencil")
                                .symbolVariant(buttonShapesEnabled ? .circle : .none)
                        })
                        .sheet(isPresented: $showIssueComposer, content: {
                            ComposerView()
                        })
                    }
                }
                .navigationTitle("Issues")
            }
        } detail: {
            Text("Select an item")
        }
    }
    
    private func composeIssue() {
        
    }
}

#Preview {
    IssuesView()
        .modelContainer(for: Issue.self, inMemory: true)
}
