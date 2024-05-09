//
//  ThumbsView.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 5/8/24.
//

import SwiftUI

struct ThumbsView: View {
    
    //TODO: this is where we save the result of the response
    //for future use. 
    
    var body: some View {
            GroupBox {
                HStack {
                    Text("Powered by Gemini. Double-check responses.")
                        .font(.caption)
                    HStack(spacing: 20) {
                        Button(action: {
                            // Handle thumbs up action
                        }) {
                            Image(systemName: "hand.thumbsup.fill")
                                .font(.subheadline)
                        }
                        
                        Button(action: {
                            // Handle thumbs down action
                        }) {
                            Image(systemName: "hand.thumbsdown.fill")
                                .font(.subheadline)
                        }
                        
                        Button(action: {
                            // Handle save action
                        }) {
                            Image(systemName: "repeat.circle.fill")
                                .font(.subheadline)
                        }
                        
                        Button(action: {
                            // Handle save action
                        }) {
                            Image(systemName: "square.and.arrow.down.fill")
                                .font(.subheadline)
                        }
                    }
                }

            }
            .padding()
            .frame(maxWidth: .infinity)
        }
}

#Preview {
    ThumbsView()
}
