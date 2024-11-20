//
//  vikramApp.swift
//  vikram
//
//  Created by Vikram on 15/11/24.
//

import SwiftUI
import SwiftData

@main
struct DeliveryApp: App {
    var container: ModelContainer = {
        let schema = Schema([
            Delivery.self,
            Favorite.self
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
            DeliveryListView(modelContext: container.mainContext)
        }
        .modelContainer(container)
    }
}
