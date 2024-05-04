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
@Binding var searchRegion: MKCoordinateRegion?  //todo: remove optional parameter.
@Binding var searchResults: [MKMapItem]

  var body: some View {
      ScrollView {
          VStack {
              HStack {
                Text("Run Buddy")
                      .font(.largeTitle)
                      .bold()
                Spacer()
              }
              
              GroupBox {
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
              }
              
              VStack {
                  Divider()
                    .background(.gray)
              }
              .frame(height: 50) // set the desired VStack height
        
              VStack (alignment: .leading, content: {
                  Text("STATISTICS")
                      .font(.subheadline)
                  
                  GroupBox {
                      
                      LabeledContent("Longitude:") {
                        Text("Testing")
                      }
                      .padding(.bottom, 10)
                                            
                      LabeledContent("Latitude:") {
                        Text("Testing")
                      }
                      .padding(.bottom, 10)
                      
                      LabeledContent("Altitude:") {
                        Text("Testing")
                      }
                      
                  }
                  
              })

              /*
              HStack {
                  Text(searchRegion.debugDescription)
              }
             */
          }
          .buddySheetStyle()
          Spacer() //VStack align to the top
          
      }
  } //end view
}


#Preview {
    @State var visibleRegion: MKCoordinateRegion? = .washington
    @State var searchResults: [MKMapItem] = []
    return VStack {
        QuestionView(searchRegion: $visibleRegion, searchResults: $searchResults)
    }
}
