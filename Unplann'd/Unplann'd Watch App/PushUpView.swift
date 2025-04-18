//
//  PushUp.swift
//  Unplann'd
//
//  Created by Lou El Idrissi on 3/24/25.
//

import SwiftUI

struct PushUpView: View {
    var body: some View {
        VStack {
            Text("Push-Up")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Text("Perform as many push-ups as you can in 1 minute!")
                .multilineTextAlignment(.center)
                .padding()

            Spacer()
        }
        
    }
}

