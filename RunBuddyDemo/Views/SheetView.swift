//
//  SheetView.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/16/24.
//
import SwiftUI
import MapKit

struct SheetView: View {
    @State private var search: String = ""

    var body: some View {
        VStack {
            // 1
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search for a location", text: $search, onCommit: {
                    //TODO: conduct search and display results.
                    //transition map to the first location automatically.
                })
                .autocorrectionDisabled()
            }
            .buddyFieldStyle()
            Spacer()
        }
        .buddySheetStyle()
    }
}



#Preview {
    SheetView()
}
