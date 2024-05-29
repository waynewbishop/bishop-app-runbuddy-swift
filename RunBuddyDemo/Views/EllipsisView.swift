//
//  AnimateTest.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/26/24.
//

import SwiftUI

struct EllipsisView: View {
    
    @Binding var isAnimating: Bool
    var size: CGFloat = 35
    
    var body: some View {
        
        Image(systemName: "lines.measurement.horizontal")
            .resizable()
            .aspectRatio(contentMode: .fit) // Maintain aspect ratio
            .foregroundColor(.blue)
            .frame(width: size, height: size)
            .symbolRenderingMode(.hierarchical)
            
            //only animate based on boolean value
            .symbolEffect(.variableColor.iterative.reversing, isActive: isAnimating)
            
    }
}

//special preview macro for testing animation state..
#Preview {
    @State var toggle: Bool = true
    return VStack {
        EllipsisView(isAnimating: $toggle, size: 100)
    }
}
