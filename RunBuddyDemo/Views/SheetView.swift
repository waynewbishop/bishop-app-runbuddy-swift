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
            .padding(12)
            .background(.gray.opacity(0.1))
            .cornerRadius(8)
            .foregroundColor(.primary)

            Spacer()
        }
        .padding()
        .interactiveDismissDisabled()
        .presentationDetents([.height(200), .large])
        .presentationBackground(.thickMaterial)
        .presentationBackgroundInteraction(.enabled(upThrough: .large))
    }
}



#Preview {
    SheetView()
}
