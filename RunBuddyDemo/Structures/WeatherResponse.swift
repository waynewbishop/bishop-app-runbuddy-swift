//
//  OpenWeatherResponse.swift
//  RunBuddyDemo
//
//  Created by Wayne Bishop on 5/24/24.
//

import Foundation

struct WeatherResponse: Codable {
    let list: [ForecastData]
    let city: City
}

struct ForecastData: Codable {
    let dt: Int
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let clouds: Clouds
    let dt_txt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, wind, clouds
        case dt_txt = "dt_txt"
    }
}

struct Main: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case temp_min = "temp_min"
        case temp_max = "temp_max"
        case humidity
    }
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Wind: Codable {
    let speed: Double
}

struct Clouds: Codable {
    let all: Int
}

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}
