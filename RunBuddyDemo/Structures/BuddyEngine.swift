//
//  BuddyEngine2.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/19/24.
//

import Foundation

import Foundation
import GoogleGenerativeAI


class BuddyEngine: ObservableObject {

    @Published var chunkResponse: String = ""

    init() {
     //default initalizer
    }
    
   private func newTextModel(with key: String) -> GenerativeModel {
        let model = GenerativeModel(name: "gemini-pro", apiKey: key)
        return model
    }
    
    
    func getGenerativeTextChunkAnswer(prompt: String, apiKey: String?) async throws -> () {
        
        //check for apiKey
        guard let key = apiKey else {
            throw GenerateContentError.invalidAPIKey(message: "error: invalid api key..")
        }

        let model = newTextModel(with: key)
        
        //TODO: With main functionality working, now we can build out a strongly typed model for the prompt.
        let prompt: String = prompt
        
        // Use streaming with text-only input
        let contentStream = model.generateContentStream(prompt)
                
        do {
            for try await chunk in contentStream {
                if let text = chunk.text {
                    print(text)
                    
                    //update published property on main thread
                    DispatchQueue.main.async {
                        self.chunkResponse += text
                    }
                }
            }
        } //end do
        catch {
            //throw general exception
            print("something went wrong..")
            throw error
        }
        
    } //end function

    
} //end class
