//
//  AnimateTest.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/26/24.
//

import SwiftUI

struct AnimateTest: View {
    
    @Binding var isGenerating: Bool
    
    var body: some View {
        
        Image(systemName: "wave.3.forward.circle.fill")
            .resizable()
            .aspectRatio(contentMode: .fit) // Maintain aspect ratio
            .foregroundColor(.blue)
            .frame(width: 30, height: 30)
            
            //only animate based on boolean value
            .symbolEffect(.variableColor.iterative.reversing, isActive: isGenerating)
            
    }
}

//special preview macro for testing animation state..
#Preview {
    @State var toggle: Bool = true
    return VStack {
        AnimateTest(isGenerating: $toggle)
    }
}
