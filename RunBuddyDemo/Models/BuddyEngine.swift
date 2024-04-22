//
//  BuddyModel.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/10/24.
//

import Foundation
import GoogleGenerativeAI

/*
 Create test where BuddyEngine runs as a struct. The goal is to obtain the latest answer data as it streams..
 There should be no single return objects as I pushing out streamed content as I receive it. If this doesn't
 work then we can alway extend the model to support delegation, but doing it as a struct could provide more flexibility in the new SwiftUI model.
*/
class BuddyEngine: ObservableObject {
    
    @Published var model: GenerativeModel
    @Published var chunkResponse: String = ""
    
    init(_ key: String = "") {
        //initialize the model - latest version
        model = GenerativeModel(name: "gemini-pro", apiKey: key)
    }
    
    //get the answer to a basic question via text..
    func getGenerativeTextAnswer(prompt: String) async throws -> String? {
        
        //TODO: Now come up with a list of consistent parameters to provide a consistent set of responses..
        //TODO: Also need to find a way to return a single paragraph. Also limit the number of characters returned.
        
        do {
            
            let response = try await model.generateContent("I took two gels on a 7 mile long last week and it was 70 degrees at sea level. Should I do the same thing this Saturday or change my strategy? It will be 65 degrees and sunny. I will also be doing 10 miles at 2500 feet. This will be training effort only and I will not be racing. Provide a single 50-75 word paragraph for a suggested strategy. Use two paragraphs if needed. The general tone of the response should be upbeat, positive and encouraging.")
            
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
    //MARK: This may not be needed. Do additional testing to see how this works..
    func getGenerativeChatAnswer(prompt: String) async throws -> String? {
        return nil
    }
    

    func getGenerativeTextStreamAnswer(prompt: String) async throws -> String? {
        
        let prompt = "How do I get started in running? Provide a single 50-75 word paragraph for a suggested strategy. Use two paragraphs if needed. The general tone of the response should be upbeat, positive and encouraging."
        
        var fullResponse = ""
        
        // Use streaming with text-only input
        let contentStream = model.generateContentStream(prompt)
                
        do {
            for try await chunk in contentStream {
                if let text = chunk.text {
                    
                    //TODO: if I receive data in chunks perhaps the results should be written to a binding.
                    print(text)
                    fullResponse += text
                }
            }
            
            print(fullResponse)
            return fullResponse
        }
        catch {
            print("Error generating answer: \(error)")
            return nil
        }
        
    } //end function
    

    //TODO: Work on this model as this does not have a return value..
    func getGenerativeTextChunkAnswer(prompt: String) async throws -> () {
        
        let prompt = "How do I get started in running? Provide a single 50-75 word paragraph for a suggested strategy. Use two paragraphs if needed. The general tone of the response should be upbeat, positive and encouraging."
        
        var fullResponse = ""
        
        // Use streaming with text-only input
        let contentStream = model.generateContentStream(prompt)
                
        do {
            for try await chunk in contentStream {
                if let text = chunk.text {
                    
                    //TODO: if I receive data in chunks perhaps the results should be written to a published class property.
                    print(text)
                    chunkResponse = text
                    fullResponse += text
                }
            }
            
            print(fullResponse)
        }
        catch {
            print("Error generating answer: \(error)")
        }
        
    } //end function

    
} //end class
