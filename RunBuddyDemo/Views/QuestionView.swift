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

    /*
     note: obtain the placemark information when
     doing the runbuddy analysis. The goal will be to
     pass the details of the search location to
     Gemini in order to get an rough idea of the
     destination elevation.
     */
    
@State var name: String = ""
@State var distance: String = ""
@State var selectedDate = Date()
@State var selectedTime = Date()
@State var selectedOption = "Easy"
@State var nutrition: Bool = false
@State var kit: Bool = false
@State var hydration: Bool = false

//transition variables
@State var isAnimating: Bool = false
@State var showModal: Bool = false

var latitude: String {
    if let region = searchRegion {
        let roundedLatitude = region.center.latitude.rounded(to: 5)
        return String(roundedLatitude)
    } else {
        return ""
    }
}

var longitude: String {
    if let region = searchRegion {
        let roundedLongitude = region.center.longitude.rounded(to: 5)
        return String(roundedLongitude)
    } else {
        return ""
    }
}
    
  var body: some View {
      ScrollView {
          VStack {
              Spacer()
          }
          VStack {
              HStack {
                  Text("Run Buddy")
                      .font(.largeTitle)
                      .bold()
                     // .padding()
                 Spacer()
              }
              
              GroupBox {
                  HStack {
                      Image(systemName: "magnifyingglass")
                      TextField("Search for a run location", text: $name, axis: .vertical)
                          .autocorrectionDisabled()
                          .onSubmit() {
                              let engine = SearchEngine(searchResults: $searchResults)
                                                          
                              Task {
                                  do {
                                      try await engine.search(for: name, in: .washington)
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
                      
                      LabeledContent("Run Type") {
                         SelectionView(selectedOption: $selectedOption)
                         .padding(.bottom, 20)
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
                  }
              })
              
          }
          .buddySheetStyle()
          Spacer() //top align VStack
          
          VStack {
              
              HStack {
                  EllipsisView(isAnimating: $isAnimating)
                  Button("Ask RunBuddy..") {
                      showModal = true
                  }
                  .sheet(isPresented: $showModal) {
                      
                      if let region = searchRegion {
                          let location = region.center
                          
                          let question = Question(name: name, location: location, distance: distance, targetDate: selectedDate, targetTime: selectedTime, selectedOption: selectedOption, nutrition: nutrition, kit: kit, hydration: hydration)
                          
                          AnalysisView(showModal: $showModal, question: question)
                      }
                  }
               .padding(5)
              }
            
          }
          
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
