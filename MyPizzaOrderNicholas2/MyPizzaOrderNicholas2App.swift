//
//  MyPizzaOrderNicholas2App.swift
//  MyPizzaOrderNicholas2
//
//  Created by Nicholas Sullivan on 2024-10-15.
//
//  Nicholas Sullivan
//  991612414
//  Assignment 2

import SwiftUI

@main
struct MyPizzaOrderNicholas2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
