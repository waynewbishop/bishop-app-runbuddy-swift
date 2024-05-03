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
                Spacer()
              }
              
              HStack {
                  Image(systemName: "magnifyingglass")
                  TextField("Search for map location", text: $location, axis: .vertical)
                      .autocorrectionDisabled()
                      .onSubmit() {
                          let engine = SearchEngine(searchResults: $searchResults)
                          
                          Task {
                              do {
                                  try await engine.search(for: location, in: .washington)
                              }
                              catch {
                                  print(error.localizedDescription)
                              }
                          } //end task
                      }
              }
              .buddyFieldStyle()
                            
              HStack {
                  Label("Altitude:", systemImage: "mountain.2.fill")
                  Spacer()
              }
              .padding(10)
              
              VStack {
                  Divider()
                    .background(.gray)
              }
              .frame(height: 10) // set the desired VStack height
              
              HStack {
                  Text(searchRegion.debugDescription)
              }
          }
          .buddySheetStyle()
          Spacer() //VStack align to the top
          
          
      } //end view
}


#Preview {
    @State var visibleRegion: MKCoordinateRegion? = .washington
    @State var searchResults: [MKMapItem] = []
    return VStack {
        QuestionView(searchRegion: $visibleRegion, searchResults: $searchResults)
    }
}
