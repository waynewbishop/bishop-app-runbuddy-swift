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
    
    func search(for query: String, in searchRegion: MKCoordinateRegion) async throws -> () {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        
        //searchable region
        request.region = searchRegion
        
        let search = MKLocalSearch(request: request)
        
        do {
            let response = try await search.start()
            
            //update binding property on main thread
            DispatchQueue.main.async {
                self.searchResults = response.mapItems
                print("\(searchResults.count) search results..")
            }
          } catch {
            //throw a general error
            print("Error during search..")
            throw error
          }
        
    } //end function
}


