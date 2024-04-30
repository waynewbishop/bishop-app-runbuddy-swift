//
//  MapWithSearch.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/28/24.
//

import SwiftUI
import MapKit

struct MapWithSearch: View {
    
  @State private var searchText = ""
  @State private var isSheetPresented: Bool = true

  var body: some View {
    ZStack {
      
      //assign map as the base layer
      Map(initialPosition: .automatic) {
        
      }
      .mapStyle(.standard(elevation: .realistic))
        
      .onTapGesture { position in
          print("now tapping the screen at position: \(position)")
      }
        
      //start creating the list to hold he
      .sheet(isPresented: $isSheetPresented) {
          SheetView()
      }
      VStack {
          // 1
          HStack {
              Image(systemName: "magnifyingglass")
              TextField("Search for a location", text: $searchText, onCommit: {
                  //find results and move map to the first position
                  print("now searching for results..")
              })
              .autocorrectionDisabled()
          }
          .padding(11)
          .background(.white.opacity(0.9))
          .cornerRadius(8)
          .foregroundColor(.primary)

          Spacer()
      }
      .padding() // Add padding for aesthetics
    }
  }

  // Other map related properties and functions...
}


#Preview {
    MapWithSearch()
}
