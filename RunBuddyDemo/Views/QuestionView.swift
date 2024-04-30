//
//  QuestionView.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/30/24.
//

import SwiftUI

struct QuestionView: View {

@State var location: String = "Choose a map location"

      var body: some View {
          
          VStack {
              HStack {
                Text("Run Buddy")
                      .font(.largeTitle)
                      .bold()
                Spacer() //align text to left edge..
              }
              
              HStack {
                  Image(systemName: "mappin.and.ellipse")
                  TextField("Waiting for an answer..", text: $location, axis: .vertical)
              }
              .disabled(true) //disables user interaction
              .buddyTextStyle()
              
              HStack {
                  Label("Altitude:", systemImage: "mountain.2.circle")
                  Spacer()

              }
              .padding(10)
              
              VStack {
                  Divider()
                    .background(.gray) // set the color of the line (optional)
              }
              .frame(height: 10) // set the desired height for the VStack (controls Spacer height)
          }
          .padding()
        Spacer() //align to the top
      }
}

#Preview {
    QuestionView()
}
