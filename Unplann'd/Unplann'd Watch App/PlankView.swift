//
//  Plank.swift
//  Unplann'd
//
//  Created by Lou El Idrissi on 3/25/25.
//

import SwiftUI

struct PlankView: View {
    var body: some View {
        VStack {
            Text("Plank")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Text("Hold a plank for as long as possible. Keep your form strong!")
                .multilineTextAlignment(.center)
                .padding()

            Spacer()
        }
        
    }
}
