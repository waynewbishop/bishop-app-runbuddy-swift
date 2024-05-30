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
            .padding()
            
            VStack {
                Text("Gig Harbor")
                    .font(.largeTitle)
                
                Text("Wednesday, May 29")
                    .font(.subheadline)
            }
            
            VStack {
                //insert swift chart statistics
                //only if the target date is 5 days or less from the
                //current date. If not show a some sort of custom view
                //that explains how it works..
                ForecastView()
            }
                                    
            Spacer() //keep everything top aligned..
        }
        //provide .padding() around subviews..
        
    }
    
}



#Preview {

    @State var showModal: Bool  = false
    return VStack {
        AnalysisView(showModal: $showModal)
    }

}
