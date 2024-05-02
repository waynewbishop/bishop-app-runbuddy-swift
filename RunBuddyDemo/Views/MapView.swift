//
//  MapView.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/15/24.
//

import SwiftUI
import MapKit


extension MKCoordinateRegion {

    static let washington = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 44.95095247964279, longitude: -120.72892421454331), span: MKCoordinateSpan(latitudeDelta: 13.248434414740949, longitudeDelta: 8.63519284897437))
}


struct MapView: View {
    
    @State private var position: MapCameraPosition = .region(.washington)
    @State private var visibleRegion: MKCoordinateRegion?
    @State private var isSheetPresented: Bool = true
    @State var searchResults: [MKMapItem] = []
    
    var body: some View {
        
        Map(initialPosition: position) {
            
            ForEach(searchResults, id:\.self) { result in
                Marker(item: result)
            }
            
         /*
         MapCircle(center: .elDoradoPark, radius: CLLocationDistance(250))
             .foregroundStyle(.orange.opacity(0.60))
             .mapOverlayLevel(level: .aboveLabels)
         
         MapCircle(center: .golfCourse, radius: CLLocationDistance(350))
             .foregroundStyle(.teal.opacity(0.60))
             .mapOverlayLevel(level: .aboveRoads)
         */
         
        }
        .ignoresSafeArea()
        .mapStyle(.standard(elevation: .realistic))
        .onTapGesture { position in
            print("now tapping the screen..")
        }
        .onMapCameraChange { context in
            visibleRegion = context.region
           // print(visibleRegion!)
        }
        .sheet(isPresented: $isSheetPresented) {
            QuestionView(searchRegion: $visibleRegion, searchResults: $searchResults)
        }
    }
}

#Preview {
    MapView()
}
