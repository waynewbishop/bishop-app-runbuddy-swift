//
//  PromptModel.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 4/19/24.
//

import Foundation
import CoreLocation

struct Prompt {
    
    //creata a prompt based on weather requirements
    func newWeatherPrompt(forecasts: [ForecastData], location: CLLocationCoordinate2D, distance: Double, targetDate: Date) -> String?  {
        return nil
    }

    //create a prompt based on nutritional requirements
    func newNutritionPrompt(location: CLLocationCoordinate2D, distance: Double, targetDate: Date) -> String? {
        return nil
    }
    
    //create a prompt based on hydration requirements
    func newHydrationPrompt(location: CLLocationCoordinate2D, distance: Double, targetDate: Date) -> String? {
        return nil
    }
    
    //create a prompt baseed on clothing requirements
    func newClothingPrompt(location: CLLocationCoordinate2D, distance: Double, targetDate: Date) -> String? {
        return nil
    }
    
    
}

//MARK: these are just sample prompts to be used for testing..

extension String {
    
    static let promptParkrunSample: String = "I will be running 3.1 mile threshold effort at Perrigo Park in Redmond WA this coming Staturday at 9AM. It will be 45 degrees and cooler temperatures for this time of year with the possibility of rain showers sometime during the event. The altitude will be approximatley close to sea level. Provide a single 75-100 word essay for a suggested strategy. Use two paragraphs if needed. Include some common strategies for running 5K events. Include clothing and hydration advice. The general tone of the response should be upbeat, positive and encouraging."
    
    static let prompt10MileSample: String = "I took two gels on a 7 mile long last week and it was 70 degrees at sea level. Should I do the same thing this Saturday or change my strategy? It will be 65 degrees and sunny. I will also be doing 10 miles at 2500 feet. This will be training effort only and I will not be racing. Provide a single 50-75 word paragraph for a suggested strategy. Use two paragraphs if needed. The general tone of the response should be upbeat, positive and encouraging."
    
    static let promptNewRunner: String = "How do I train for a marathon? Provide a single 75-100 word essay for a suggested strategy. Use two paragraphs if needed. The general tone of the response should be upbeat, positive and encouraging. Be sure not to use any titles or sub headings in the response."
    
    static let promptTrailRace: String = "I have a 6.2 mile trail race this weekend and the course has 800 feet of vertical and will be around 2K above sea level in Marin Headlands. I currnetly run around 25 per week and aim to do around 800 of vertical per week. Provide nutrition suggestions before, during and after the event. Also clothing suggestions for the race. Provide a single 75-150 word paragraph for a suggested strategy. Use two or three paragraphs if needed. The general tone of the response should be upbeat, positive and encouraging. Be sure not to use any titles or sub headings in the response. The response should also be in English."
    
}
