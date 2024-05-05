//
//  QuestionView.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/30/24.
//

import SwiftUI
import MapKit

struct QuestionView: View {

@Binding var searchRegion: MKCoordinateRegion?
@Binding var searchResults: [MKMapItem]
    
@State var location: String = ""
@State var distance: String = ""
@State var selectedDate = Date()
@State var selectedTime = Date()
@State var nutrition: Bool = true
@State var kit: Bool = true
@State var hydration: Bool = true

    
var latitude: String {
  //TODO: compute property from searchRegion
    return searchRegion.debugDescription
}

var longitude: String {
   return ""
}

var altitude: String {
   return ""
}

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
                  Text("MAP DETAILS")
                      .font(.subheadline)
                  
                  GroupBox {
                      LabeledContent("Latitude") {
                        Text(latitude)
                      }
                      .padding(.bottom, 15)
                                            
                      LabeledContent("Longitude") {
                        Text(longitude)
                      }
                      .padding(.bottom, 15)
                      
                      LabeledContent("Altitude") {
                        Text(altitude)
                      }
                  }
              })
              
              VStack {
                  Divider()
                    .background(.gray)
              }
              .frame(height: 50) // set the desired VStack height
                      
              VStack (alignment: .leading, content: {
                  Text("RUN DETAILS")
                      .font(.subheadline)
                  
                  GroupBox {
                     
                      HStack {
                        TextField("Run distance (miles)", text: $distance)
                          .keyboardType(.decimalPad)
                          .padding(.bottom, 15)
                      }
                    
                      LabeledContent("Start Date") {
                          DatePicker("Start Date", selection: $selectedDate, displayedComponents: .date)
                                 .labelsHidden()
                                 .padding(.bottom, 15)
                      }
                      
                      LabeledContent("Start Time") {
                          DatePicker("Start Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                                 .labelsHidden() 
                                 .padding(.bottom, 20)
                      }
                    
                      Toggle(isOn: $nutrition) {
                          Text("Nutrition Analysis")
                      }
                      .padding(.bottom, 15)
                      
                      Toggle(isOn: $hydration) {
                          Text("Hydration Analysis")
                      }
                      .padding(.bottom, 15)
                      
                      Toggle(isOn: $kit) {
                          Text("Clothing Analysis")
                      }
                      .padding(.bottom, 15)
                      
                      VStack {
                          Divider()
                            .background(.gray)
                      }
                      .frame(height: 50) // set the desired VStack height
                
                  }
              })
              
          }
          .buddySheetStyle()
          Spacer() //top align VStack
          
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
