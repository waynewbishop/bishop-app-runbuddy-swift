//
//  StyledViewModifier.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/30/24.
//

import SwiftUI

struct FieldStyleModifier: ViewModifier {

  let cornerRadius: CGFloat
  let backgroundOpacity: Double
  let foregroundColor: Color
  let setBackgroundColor: Bool

    init(cornerRadius: CGFloat = 8, backgroundOpacity: Double = 0.2, foregroundColor: Color = .primary, setBackgroundColor: Bool = false) {
        
    self.cornerRadius = cornerRadius
    self.backgroundOpacity = backgroundOpacity
    self.foregroundColor = foregroundColor
    self.setBackgroundColor = setBackgroundColor
  }

  func body(content: Content) -> some View {
    content
      .padding(15)
      //.background(.yellow.opacity(backgroundOpacity))
      .background(setBackgroundColor ? Color.yellow.opacity(backgroundOpacity) : Color.clear)
      .cornerRadius(cornerRadius)
      .foregroundColor(foregroundColor)
      .disabled(true)
      .frame(minHeight: 20)
  }
}

//the applied name of the modifier
extension View {
    func buddyFieldStyle(setBackgroundColor: Bool) -> some View {
        modifier(FieldStyleModifier(setBackgroundColor: setBackgroundColor))
    }
}

//provide a sample preview
 #Preview {
     @Previewable @State var sampleText: String = "Hello World!"
     @Previewable @State var toggle: Bool = true
     
     return HStack {
         TextField("Waiting for an answer..", text: $sampleText)
             .buddyFieldStyle(setBackgroundColor: toggle)
     }
     .padding()
 }
