//
//  Weather_AppApp.swift
//  Weather_App
//
//  Created by Mohammad Mendahawi on 8/30/24.
//

import SwiftUI
import SwiftData

@main
struct Weather_AppApp: App {
    @StateObject private var locationManager = LocationManager()  
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
                .environmentObject(locationManager)  
        }
        .modelContainer(sharedModelContainer)
    }
}
