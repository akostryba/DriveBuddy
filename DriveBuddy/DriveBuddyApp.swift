//
//  akostrybaApp.swift
//  akostryba
//
//  Created by Andrew Kostryba on 5/30/24.
//

import SwiftUI

@main
struct DriveBuddyApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
