//
//  AnalysisView.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 5/24/24.
//

import SwiftUI
import CoreLocation


extension CLLocationCoordinate2D {
    static let gigHarbor = CLLocationCoordinate2D(latitude: 47.64373, longitude: -122.17364)
}

struct AnalysisView: View {
    
    @Binding var showModal: Bool
    
    @State var question: Question
    @State var isAnimating: Bool = true
        
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
            
            ScrollView {
                
                VStack {
                    //insert swift chart statistics
                    //only if the target date is 5 days or less from the
                    //current date. If not show a some sort of custom view
                    //that explains how it works..
                    ForecastView(location: question.location)
                }
                Spacer() //keep everything top aligned..
                
            } //end scrollview
            .onAppear() {
                print(question)
            }
        }
    }
}



#Preview {
    @State var showModal: Bool  = false
    @State var testQuestion = Question(name: "Gig Harbor", location: .gigHarbor, distance: "3.1", targetDate: Date(), targetTime: Date(), selectedOption: "Easy", nutrition: false, kit: false, hydration: false)
    
    return VStack {
        AnalysisView(showModal: $showModal, question: testQuestion)
    }

}
