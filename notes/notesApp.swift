//
//  notesApp.swift
//  notes
//
//  Created by Nick Spaargaren on 15/05/2024.
//

import SwiftUI
import SwiftData

@main
struct notesApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Time.self,
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
            TabView {
                ContentView()
                    .tabItem {
                    Label("Home", systemImage: "house")
                }
                StatsView()
                    .tabItem {
                    Label("Stats", systemImage: "chart.xyaxis.line")
                }
            }
         
        }
        .modelContainer(sharedModelContainer)
    }
}
