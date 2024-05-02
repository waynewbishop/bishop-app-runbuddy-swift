//
//  PromptModel.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/19/24.
//

import Foundation
import CoreLocation

struct Prompt: Codable {
    
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
    
    static let promptNewRunner: String = "How do I train for a marathon? Provide a single 75-100 word essay for a suggested strategy. Use two paragraphs if needed. The general tone of the response should be upbeat, positive and encouraging. Be sure not to use any titles or sub headings in the response."
    
    static let promptTrailRace: String = "I have a 6.2 mile trail race this weekend and the course has 800 feet of vertical and will be around 2K above sea level in Marin Headlands. I currnetly run around 25 per week and aim to do around 800 of vertical per week. Provide nutrition suggestions before, during and after the event. Also clothing suggestions for the race. Provide a single 75-150 word paragraph for a suggested strategy. Use two or three paragraphs if needed. The general tone of the response should be upbeat, positive and encouraging. Be sure not to use any titles or sub headings in the response. The response should also be in English."
    
}
