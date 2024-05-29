//
//  AnalysisView.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 5/24/24.
//

import SwiftUI
import CoreLocation

struct AnalysisView: View {
    
    @Binding var showModal: Bool
    @State var targetForecast: ForecastData?
    
    
    //TODO: information recieved as a single prompt request (struct) or as loose parameters
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
    }
}



#Preview {

    @State var showModal: Bool  = false
    return VStack {
        AnalysisView(showModal: $showModal)
    }

}
