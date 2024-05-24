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
private let apiKey: String? = BuddyConfig.geminiApiKey

    var body: some View {
        HStack {
            VStack {
                HStack {
                    EllipsisView(isGenerating: $isAnimating)
                    Button("Ask RunBuddy..") {
                        self.askRunBuddyAndGetResponse()
                    }
                 .padding(5)
                }
                                
                TextField("", text: $engine.chunkResponse, axis: .vertical)
                    .buddyFieldStyle(setBackgroundColor: isOn)
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
        
    //invoke engine and receive response.
    private func askRunBuddyAndGetResponse() {
        
        //reset interface elements
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
    } //end function
}


#Preview {
    @State var showGroupBox: Bool = false
    return VStack {
        AnswerView(showGroupBox: showGroupBox)
    }
}

