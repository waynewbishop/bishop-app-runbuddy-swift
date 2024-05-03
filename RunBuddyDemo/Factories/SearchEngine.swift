//
//  SearchEngine.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 5/1/24.
//

import Foundation
import MapKit
import SwiftUI

struct SearchEngine {

    @Binding var searchResults: [MKMapItem]
    
    func search(for query: String, in searchRegion: MKCoordinateRegion) async -> () {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        
        //searchable region set the map selection
        request.region = searchRegion
        
        Task {
            
            let search = MKLocalSearch(request: request)
            if let response = try? await search.start() {
                
                //update binding property on main thread
                DispatchQueue.main.async {
                    self.searchResults = response.mapItems
                    print("\(searchResults.count) search results..")
                }
            }
            else {
                print("error: no results found..")
            }
            
        } //end task
    }
}


