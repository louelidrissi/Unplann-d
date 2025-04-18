//
//  ContentView.swift
//  Unplann'd Watch App
//
//  Created by Lou El Idrissi on 3/24/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var workoutManager = WorkoutManager()
    
//    @ViewBuilder
//    private func workoutView(for workout: String) -> some View {
//        switch workout {
//        case "Push-Up":
//            PushUpView() // or replace with your actual PushUpView
//        case "Plank":
//            PlankView() // Replace with your actual PlankView
//        case "Jumping Jack":
//            JumpingJackView() // Replace with your actual JumpingJackView
//        default:
//            Text("default")
//            // WorkoutPage(workoutManager: workoutManager)
//        }
//    }
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    WelcomePage(workoutManager: workoutManager)
                        .onAppear {
                     //       print("onAppear called!")
                            NotificationManager.shared.requestAuthorization()
                            NotificationManager.shared.scheduleMultipleWorkoutNotifications(count: 4)
                        }
//                        .navigationDestination(isPresented: $workoutManager.navigateToWorkout) {
//                                if let workout = workoutManager.selectedWorkout {
//                                    workoutView(for: workout) // Use your dynamic function
//                                } else {
//                                    Text("No workout selected")
//                                }
//                            }
                    
//                    Button("Get Random Workout") {
//                        workoutManager.scheduleRandomWorkout() // Manual Trigger for Debugging
//                        NotificationManager.shared.scheduleMultipleWorkoutNotifications(count: 1)
//                    }
                }
//                .onChange(of: workoutManager.selectedWorkout) { newWorkout in
//                    if let workout = newWorkout {
//                        print("Workout changed to: \(workout)")
//                        // Ensure the workout is passed to scheduleWorkoutNotification with the correct timing
//                               let calendar = Calendar.current
//                               let currentDate = Date()
//                               let notificationTime = calendar.date(byAdding: .minute, value: 1, to: currentDate)! // Set a 1-minute delay for demonstration
//                               
//                               // Convert the future time into DateComponents
//                               let notificationDateComponents = calendar.dateComponents([.hour, .minute], from: notificationTime)
//
//                               NotificationManager.shared.scheduleWorkoutNotification(workout: workout, at: notificationDateComponents)
//                           
//                    }
//                }
            }
        }
    }
}
    
        

struct WelcomePage: View {
    @ObservedObject var workoutManager: WorkoutManager
    
    var body: some View {
        VStack(spacing: 5) {
            // Welcome message
            Text("Unplann'd")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(.top)
            
           
            // Navigation Links for each exercise
            NavigationLink(destination: PushUpTracker()) {
                Text("Push-Up")
                    .font(.headline)
                    //font(.system(size: 14))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            NavigationLink(destination: PlankTracker()) {
                Text("Plank")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            NavigationLink(destination: JumpingJackTracker()) {
                Text("Jumping Jack")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
             
            }
            .padding()
             
        }
    }
}

#Preview {
    ContentView()
}
