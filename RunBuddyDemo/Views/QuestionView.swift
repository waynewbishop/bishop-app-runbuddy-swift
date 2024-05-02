//
//  QuestionView.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/30/24.
//

import SwiftUI
import MapKit

struct QuestionView: View {

@State var location: String = ""
@Binding var searchRegion: MKCoordinateRegion?
@Binding var searchResults: [MKMapItem]

      var body: some View {
          VStack {
              HStack {
                Text("Run Buddy")
                      .font(.largeTitle)
                      .bold()
                Spacer() //align text to left edge..
              }
              
              HStack {
                  Image(systemName: "magnifyingglass")
                  TextField("Search for map location", text: $location, axis: .vertical)
                      .autocorrectionDisabled()
                      .onSubmit() {
                          print("invoke code to obtain search results..")
                          print("search location \(String(describing: searchRegion))")
                      }
              }
              .buddyFieldStyle() //custom styling
              
              HStack {
                  Label("Altitude:", systemImage: "mountain.2")
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
    @State var visibleRegion: MKCoordinateRegion?
    @State var searchResults: [MKMapItem] = []
    return VStack {
        QuestionView(searchRegion: $visibleRegion, searchResults: $searchResults)
    }
}
