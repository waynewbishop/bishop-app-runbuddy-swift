//
//  AnalysisImage.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 8/6/24.
//

import SwiftUI


struct AnalysisImage: View {
        
    let imageColor: Color
    let imageName: String

    var body: some View {
        Image(systemName: imageName)
            .font(.system(size: 30, weight: .regular))
            .foregroundStyle(.white)
            .background(
                Circle()
                    .fill(imageColor.opacity(0.7))
                    .frame(width: 55, height: 70)
            )
            .frame(height: 55)
    }
}

#Preview {
    let color = Color.random()
    let name = "hanger"
    
    return VStack {
        AnalysisImage(imageColor: color, imageName: name)
    }
}


