//
//  RotatingStarView.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/25/24.
//

import SwiftUI

//TODO: remove struct parameters and just have a constants in the animation
//TODO: add a parameter to toggle animation on and off.

struct RotatingStarView: View {
    
  let color: Color // Parameter for star color
  let size: CGFloat // Parameter for star size
  let duration: Double // Parameter for animation duration
  let degrees: Double // Parameter for initial rotation (optional)

  @State private var angle: Double = 0.0

  var body: some View {
            
    Image(systemName: "star.fill")
       .resizable()
       .aspectRatio(contentMode: .fit) // Maintain aspect ratio
       .foregroundColor(color)
       .rotationEffect(Angle(degrees: angle))
       .frame(width: size, height: size)
      
       .onAppear {
          withAnimation (.easeInOut(duration: duration).repeatForever(autoreverses: true)) {
            angle = degrees + 360.0 // Apply initial rotation and then full rotation
            
          }
      }
      
  }
}


#Preview {
    RotatingStarView(color: .orange, size: 30, duration: 1.5, degrees: 90) // Set color, size, duration, and initial rotation
}
