//
//  JumpingJack.swift
//  Unplann'd
//
//  Created by Lou El Idrissi on 3/25/25.
//
import SwiftUI

struct JumpingJackView: View {
    var body: some View {
        VStack {
            Text("Jumping Jack ")
                .font(.title)
                .fontWeight(.bold)
                .padding()
          
            Text("Do as many jumping jacks as possible in 30 seconds!")
                .multilineTextAlignment(.center)
                .padding()

            Spacer()
        }
        
    }
}
