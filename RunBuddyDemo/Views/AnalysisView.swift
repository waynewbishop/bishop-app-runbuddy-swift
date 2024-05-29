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
    
    @State var isAnimating: Bool = true
    @State var city = "Gig Harbor"
    @State var temp: Int = 59
    @State var weather = "Cloudy"
    @State var targetForecast: ForecastData?
        
    //TODO: information recieved as a single prompt request (struct) or as loose parameters
    
    var body: some View {
        
        VStack {
            HStack {
                EllipsisView(isAnimating: $isAnimating)
                Spacer()
                Button(action: {
                    showModal = false
                }) {
                    Image(systemName: "xmark")
                      .resizable()
                      .frame(width: 16, height: 16)
                      .padding()
                }
            }
        
            VStack {
                Text(city)
                    .font(.largeTitle)
                
                
                Text(" \(String(temp))°")
                    .font(Font.system(size: 100, weight: .thin, design: .default))
                
                Text(weather)
                    .font(.title2)
            }
            
            Spacer() //keep everything top aligned..
        }
        .padding()
        
    }
    
}



#Preview {

    @State var showModal: Bool  = false
    return VStack {
        AnalysisView(showModal: $showModal)
    }

}
