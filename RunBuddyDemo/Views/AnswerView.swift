//
//  ContentView2.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/19/24.
//

import Foundation

import SwiftUI
import GoogleGenerativeAI

struct AnswerView: View {
    
@ObservedObject var engine = BuddyEngine()
@State var isAnimating: Bool = false
@State var showGroupBox = false
@State var isOn: Bool = false

//access key from plist.
private let apiKey: String? = BuddyConfig.apiKey

    var body: some View {
        HStack {
            VStack {
                HStack {
                    EllipsisView(isGenerating: $isAnimating)
                                        
                    Button("Ask RunBuddy..") {
                        
                        //reset interface elements..
                        isAnimating = true
                        engine.chunkResponse = ""
                        showGroupBox = false
                        isOn = false
                        
                        Task {
                          do {
                              try await engine.getGenerativeTextChunkAnswer(prompt: .promptParkrunSample, apiKey: apiKey)
                              
                          } catch {
                            print(error.localizedDescription)
                            isAnimating = false
                          }
                        }
                    }
                 .padding(5)
                } //end hstack
                
                
                TextField("", text: $engine.chunkResponse, axis: .vertical)
                    .frame(minHeight: 20)
                    .buddyFieldStyle(setBackgroundColor: isOn)
                    .disabled(true)
                    .onChange(of: engine.chunkResponse) { oldValue, newValue in
                        isAnimating = false
                        if newValue != "" {
                            showGroupBox = true
                            isOn = true
                        }
                        else {
                            showGroupBox = false
                            isOn = false
                        }
                    }
        
                if showGroupBox {
                    ThumbsView()
               }
            }
            
        }
        .padding()
        Spacer()
    }
}


#Preview {
    @State var showGroupBox: Bool = false
    return VStack {
        AnswerView(showGroupBox: showGroupBox)
    }
}

