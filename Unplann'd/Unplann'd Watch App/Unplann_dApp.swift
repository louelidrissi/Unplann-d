//
//  Unplann_dApp.swift
//  Unplann'd Watch App
//
//  Created by Lou El Idrissi on 3/24/25.
//

import SwiftUI

@main
struct Unplann_d_Watch_AppApp: App {
    @StateObject private var workoutManager = WorkoutManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
