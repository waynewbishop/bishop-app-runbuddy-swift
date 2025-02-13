//
//  FavoriteView.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 6/16/24.
//

import SwiftUI

struct FavoriteImage: View {

@Environment(\.colorScheme) private var colorScheme
    
@State var name: String
@State var displayName: String = ""
@State var icon: String
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 25, weight: .regular))
                    .foregroundStyle(.white)
                    .background(
                        Circle()
                            .fill(Color.buttonColor.opacity(1.0))
                            .frame(width: 50, height: 50)
                    )
            }
            .frame(height: 50)
            VStack {
                Text(name.truncated())
                    .font(.subheadline)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
            }
            .onAppear{
                displayName = name
            }
        }
    }
}

#Preview {
    
    @Previewable @State var name = "Zion National Park"
    let systemIcon = "mappin"
    
    return VStack {
        FavoriteImage(name: name, displayName: name, icon: systemIcon)
    }
}
