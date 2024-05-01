//
//  MapView.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/15/24.
//

import SwiftUI
import MapKit


extension MKCoordinateRegion {

    /*
     note: zoom level of set
     */
    static let seattle = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 47.59392966826332,
            longitude: -122.30586928814589),
        span: MKCoordinateSpan(
            latitudeDelta: 0.1,
            longitudeDelta: 0.09)
    )
}


struct MapView: View {
    
    //@State private var position: MapCameraPosition = .region(.seattle)
    @State private var position: MapCameraPosition = .automatic
    @State private var visibleRegion: MKCoordinateRegion?
    @State private var isSheetPresented: Bool = true
    
    var body: some View {
        
        Map(initialPosition: position) {
            
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
            print(visibleRegion!)
        }
        .sheet(isPresented: $isSheetPresented) {
            //SheetView()
            QuestionView()
        }
    }
}

#Preview {
    MapView()
}
