//
//  StyledViewModifier.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/30/24.
//

import SwiftUI

struct TextViewStyle: ViewModifier {

  let cornerRadius: CGFloat
  let backgroundOpacity: Double
  let foregroundColor: Color

  init(cornerRadius: CGFloat = 8, backgroundOpacity: Double = 0.1, foregroundColor: Color = .primary) {
    self.cornerRadius = cornerRadius
    self.backgroundOpacity = backgroundOpacity
    self.foregroundColor = foregroundColor
  }

  func body(content: Content) -> some View {
    content
      .padding(15)
      .background(.gray.opacity(backgroundOpacity))
      .cornerRadius(cornerRadius)
      .foregroundColor(foregroundColor)
  }
}

extension View {
    func buddyTextStyle() -> some View {
        modifier(TextViewStyle())
    }
}

//provide a sample preview
 #Preview {
     @State var sampleText: String = "Hello World!"
     return HStack {
         TextField("Waiting for an answer..", text: $sampleText)
             .buddyTextStyle()
     }
     .padding()
 }


