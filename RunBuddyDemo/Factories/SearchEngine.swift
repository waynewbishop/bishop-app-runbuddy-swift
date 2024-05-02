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
    
    func search(for query: String, in searchRegion: MKCoordinateRegion) {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        
        //set the searchable area. driven by use selection..
        request.region = searchRegion
        
        Task {
            let search = MKLocalSearch(request: request)
            
            if let response = try? await search.start() {
                
                //update binding property on main thread
                DispatchQueue.main.async {
                    searchResults = response.mapItems
                    print("there are \(searchResults.count) search results..")
                }
            }
        } //end task
    }
}


