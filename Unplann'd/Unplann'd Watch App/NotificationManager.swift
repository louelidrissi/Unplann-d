//
//  Untitled.swift
//  Unplann'd
//
//  Created by Lou El Idrissi on 3/25/25.
//

import UserNotifications

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()
    var workoutManager: WorkoutManager?

    private override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
        registerNotificationCategories()
    }
    
    func setWorkoutManager(_ manager: WorkoutManager) {
        self.workoutManager = manager
    }

    // Handle notification tap (user selecting an action)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
          let userInfo = response.notification.request.content.userInfo
          
          // Retrieve the workout from userInfo (stored in the notification content)
          let selectedWorkout = userInfo["workout"] as? String ?? "Default Workout"
          
          switch response.actionIdentifier {
          case "START_WORKOUT":
              DispatchQueue.main.async {
                  self.workoutManager?.selectedWorkout = selectedWorkout // Replace with dynamic workout selection
                 // self.workoutManager?.navigateToWorkout = true
                  print("hi")
              }
              
          case "SNOOZE_WORKOUT":
              // Calculate the new time (current time + 10 minutes)
              let calendar = Calendar.current
              let currentDate = Date()
              let snoozeDate = calendar.date(byAdding: .minute, value: 1, to: currentDate)!
              
              // Convert the snooze date to date components (hour and minute)
              let snoozeDateComponents = calendar.dateComponents([.hour, .minute], from: snoozeDate)
              
              // Schedule the notification with the new time (after 10 minutes)
              scheduleWorkoutNotification(workout: selectedWorkout, at: snoozeDateComponents)
                      
          default:
              break
          }

          completionHandler()
      }


    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification authorization error: \(error.localizedDescription)")
            } else {
                print("Notification permission granted: \(granted)")
                self.registerNotificationCategories()
                
                UNUserNotificationCenter.current().getNotificationSettings { settings in
//                    print("Notification settings: \(settings.authorizationStatus.rawValue)")
                }
            }
        }
    }

    private func registerNotificationCategories() {
        //print("Registering notification categories...")
        
        let snoozeAction = UNNotificationAction(
            identifier: "SNOOZE_WORKOUT",
            title: "Snooze (x min)",
            options: []
        )

        let startWorkoutAction = UNNotificationAction(
            identifier: "START_WORKOUT",
            title: "Start Workout",
            options: [.foreground]
        )

        let workoutCategory = UNNotificationCategory(
            identifier: "WORKOUT_CATEGORY",
            actions: [snoozeAction, startWorkoutAction],
            intentIdentifiers: [],
            options: []
        )

        UNUserNotificationCenter.current().setNotificationCategories([workoutCategory])

        UNUserNotificationCenter.current().getNotificationCategories { categories in
        //    print("Registered categories: \(categories)")
        }
    }
    
    // Schedule a notification
    func scheduleWorkoutNotification(workout: String, at dateComponents: DateComponents) {
        print("schedule notification for workout: \(workout) at \(dateComponents)")

        let content = UNMutableNotificationContent()
        content.title = "Time to Work Out!"
        content.body = "Your random workout is: \(workout). Get moving!"
        content.sound = .default
        content.categoryIdentifier = "WORKOUT_CATEGORY"
        content.userInfo = ["workout": workout]

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)


        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
              //  print("Notification scheduled successfully at \(dateComponents)!")
            }
        }
    }
    
    
    func scheduleMultipleWorkoutNotifications(count: Int = 1) {
        let calendar = Calendar.current
        let currentDate = Date()

        // Define the allowed time range (9 AM - 9 PM)
//        let startHour = 14
//        let endHour = 26
//
//          
        var scheduledTimes: Set<Date> = []  // Use a Set to automatically handle unique times

        //for _ in 1...count {
            print("REPEAT")
            var workout = workoutManager?.selectedWorkout//["Push-Up", "Plank", "Jumping Jack"].randomElement() ?? "Workout"

            var scheduledDate: Date?
            
            // Generate a random hour and minute within the range
            let randomHour =  calendar.component(.hour, from: currentDate)//Int.random(in: startHour..<endHour)//calendar.component(.hour, from: currentDate)//Int.random(in: startHour..<endHour)
            var randomMinute = calendar.component(.minute, from: currentDate)+1//Int.random(in: 7..<8)//calendar.component(.hour, from: currentDate) //Int.random(in: 0..<60)
            //print( randomHour, randomMinute )
            
            // Create DateComponents for the random time
            var dateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
            dateComponents.hour = randomHour
            dateComponents.minute = randomMinute
            

//            
//            // Keep generating a new time until it is unique
//            repeat {
//                //print("REPEAT")
//                // Generate a random hour and minute within the range
//                let randomHour =  calendar.component(.hour, from: currentDate)//Int.random(in: startHour..<endHour)//calendar.component(.hour, from: currentDate)//Int.random(in: startHour..<endHour)
//                var randomMinute = calendar.component(.minute, from: currentDate)+5//Int.random(in: 7..<8)//calendar.component(.hour, from: currentDate) //Int.random(in: 0..<60)
//                //print( randomHour, randomMinute )
//                
//                randomMinute += 1
//                
//                // Create DateComponents for the random time
//                var dateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
//                dateComponents.hour = randomHour
//                dateComponents.minute = randomMinute
//
//                // Convert to Date for checking uniqueness
//                if let newScheduledDate = calendar.date(from: dateComponents) {
//                    // Check if this time is unique
//                    if !scheduledTimes.contains(newScheduledDate) {
//                        scheduledDate = newScheduledDate
//                        scheduledTimes.insert(newScheduledDate)  // Add to set if unique
//                    }
//                }
//            } while scheduledDate == nil  // Continue until we find a unique time
            
            // Now schedule the notification with the unique time
//            if let validScheduledDate = scheduledDate {
//                let workout = ["Push-Up", "Plank", "Jumping Jack"].randomElement() ?? "Workout"
//                let dateComponents = calendar.dateComponents([.hour, .minute], from: validScheduledDate)
//                
            scheduleWorkoutNotification(workout: workout ?? "Push Up", at: dateComponents)
            
        
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //print("Received notification while in foreground: \(notification.request.content.userInfo)")
        completionHandler([.banner, .sound]) // Ensure the notification is displayed
    }
}
