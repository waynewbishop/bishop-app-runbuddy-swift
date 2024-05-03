//
//  TestView.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 5/2/24.
//

import SwiftUI
import MapKit

struct TestView: View {
    
    @State var location: String = ""
    @State var searchResults: [MKMapItem] = []
    
    var body: some View {
        
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search for map location", text: $location, axis: .vertical)
                    .autocorrectionDisabled()
                    .onSubmit() {
                        
                        let engine = SearchEngine(searchResults: $searchResults)
                        
                        Task {
                            await engine.search(for: location, in: .washington)
                        }
                    }
            }
            .buddyFieldStyle()
            .padding()

            //results will be refreshed when value is mutated
            HStack {
                Text(searchResults.description)
            }
            .padding()

        }
    }
}

#Preview {
    TestView()
}
