//
//  QuestionView.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/30/24.
//

import SwiftUI

struct QuestionView: View {

@State var location: String = ""

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
                  TextField("Search for map location", text: $location, axis: .vertical)
                      .autocorrectionDisabled()
              }
              .buddyFieldStyle()
              
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
          .buddySheetStyle()
          Spacer() //align to the top
          
          
      } //end view
}

#Preview {
    QuestionView()
}
