//
//  MultiView.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/16/24.
//

import SwiftUI
import MapKit

struct SearchableMap: View {
    @State private var position = MapCameraPosition.automatic
    @State private var isSheetPresented: Bool = true
    
    var body: some View {
        Map(position: $position)
            .ignoresSafeArea()
            .sheet(isPresented: $isSheetPresented) {
                SheetView()
            }
    }
}


#Preview {
    //create a new default model
    SearchableMap()
}
