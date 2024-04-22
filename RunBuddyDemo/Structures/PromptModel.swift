//
//  PromptModel.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/19/24.
//

import Foundation

class PromptModel {
    
    //TODO: should include a computed property for unrolling all the class properties into a single prompt.
    //TODO: the model should also include options for sentiment, max number of tokens and perhaps even an internal check to see if its a valid prompt.
}

//MARK: these are just sample prompts to be used for testing..

extension String {
    
    static let prompt10MileSample: String = "I took two gels on a 7 mile long last week and it was 70 degrees at sea level. Should I do the same thing this Saturday or change my strategy? It will be 65 degrees and sunny. I will also be doing 10 miles at 2500 feet. This will be training effort only and I will not be racing. Provide a single 50-75 word paragraph for a suggested strategy. Use two paragraphs if needed. The general tone of the response should be upbeat, positive and encouraging."
    
    static let promptNewRunner: String = "How do I train for a marathon? Provide a single 100-200 word essay for a suggested strategy. Use two paragraphs if needed. The general tone of the response should be upbeat, positive and encouraging."
}
