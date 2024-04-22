//
//  BuddyModel.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/10/24.
//

import Foundation
import GoogleGenerativeAI

class AnswerEngine: ObservableObject {
    
    @Published var model: GenerativeModel
    private let key: String = "AIzaSyBjMts2i3xOTtfATk7ZfUBshUUlv6QQuDU"
    
    init() {
        //initialize the model - latest version
        model = GenerativeModel(name: "gemini-pro", apiKey: key)
     }
    
    //get the answer to a basic question via text..
    func getGenerativeTextAnswer(prompt: String) async throws -> String? {

        //TODO: Now come up with a list of consistent parameters to provide a consistent set of responses..
        //TODO: Also need to find a way to return a single paragraph. Also limit the number of characters returned.
        
      do {
          
        let response = try await model.generateContent("I took two gels on a 7 mile long last week and it was 70 degrees at sea level. Should I do the same thing this Saturday or change my strategy? It will be 65 degrees and sunny. I will also be doing 10 miles at 2500 feet. This will be training effort only and I will not be racing. Provide a single 50-125 word paragraph for a suggested strategy. Use two paragraphs if needed. The general tone of the response should be upbeat, positive and encouraging.")
          
        if let text = response.text {
          print(text)
          return text
        } else {
          return nil // No text found in the response
        }
          
      } catch {
        print("Error generating answer: \(error)")
        return nil
      }

    } //end func
    
    
    //TODO: Build a model based on historical data - all of this data could be stored in a SwiftData object..
    func getGenerativeChatAnswer(prompt: String) async throws -> String? {
      return nil
    }
    
}

