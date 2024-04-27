//
//  AnimateTest.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/26/24.
//

import SwiftUI

struct EllipsisView: View {
    
    @Binding var isGenerating: Bool
    
    var body: some View {
        
        Image(systemName: "ellipsis.bubble.fill")
            .resizable()
            .aspectRatio(contentMode: .fit) // Maintain aspect ratio
            .foregroundColor(.blue)
            .frame(width: 30, height: 30)
            .symbolRenderingMode(.hierarchical)
            
            //only animate based on boolean value
            .symbolEffect(.variableColor.iterative.reversing, isActive: isGenerating)
            
    }
}

//special preview macro for testing animation state..
#Preview {
    @State var toggle: Bool = true
    return VStack {
        EllipsisView(isGenerating: $toggle)
    }
}
