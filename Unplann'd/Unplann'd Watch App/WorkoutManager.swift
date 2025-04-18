//
//  WorkoutManager.swift
//  Unplann'd
//
//  Created by Lou El Idrissi on 3/25/25.
//

import Foundation
import Combine
import UserNotifications


class WorkoutManager: ObservableObject {
    @Published var selectedWorkout: String?
    //@Published var navigateToWorkout = false
    
    func scheduleRandomWorkout() {
        let workouts = ["Push-Up", "Plank", "Jumping Jack"]
        var newWorkout: String
        repeat {
            newWorkout = workouts.randomElement()!
        } while newWorkout == selectedWorkout
        selectedWorkout = newWorkout
        print(selectedWorkout)
    }
}
