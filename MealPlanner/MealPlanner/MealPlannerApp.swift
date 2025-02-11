//
//  MealPlannerApp.swift
//  MealPlanner
//
//  Created by Chernokoz on 10.02.2025.
//

import SwiftUI

@main
struct MealPlannerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
