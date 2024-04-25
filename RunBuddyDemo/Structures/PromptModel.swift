//
//  PromptModel.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/19/24.
//

import Foundation
import CoreLocation

struct PromptModel: Codable {
    
    //time, location and duration of effort
    let lat: Float
    let long: Float
    let startDate: Date
    let distance: Float
    let duration: Float
    
    //these properties will work best when compared to previous efforts
    let temperature: Float
    let humidity: Float
    let altitude: Float
    
    //is the runner looking for advice in regards to nutrition
    let gels: Bool
    let electrolytes: Bool
    let breakfast: Bool
        
    private var minResponseTokens: Int = 50
    private var maxResponseTokens: Int = 75
    
    private var paragraphs: Int = 2
    private var tone: String = "The general tone of the response should be upbeat, positive and encouraging."

    
    //to provide nutrition and general performance
    var promptPerformance: String {
        
        //TODO: now we build out the string based on the supplied properties..
        
        return "this is a test.."
    }

    //to provide clothing recommendations
    var promptClothing: String {
        return "this is another test.."
    }
    
}

//MARK: these are just sample prompts to be used for testing..

extension String {
    
    static let prompt10MileSample: String = "I took two gels on a 7 mile long last week and it was 70 degrees at sea level. Should I do the same thing this Saturday or change my strategy? It will be 65 degrees and sunny. I will also be doing 10 miles at 2500 feet. This will be training effort only and I will not be racing. Provide a single 50-75 word paragraph for a suggested strategy. Use two paragraphs if needed. The general tone of the response should be upbeat, positive and encouraging."
    
    static let promptNewRunner: String = "How do I train for a marathon? Provide a single 100-200 word essay for a suggested strategy. Use two paragraphs if needed. The general tone of the response should be upbeat, positive and encouraging."
    
    static let promptTemperatureChange: String = ""
    
}
