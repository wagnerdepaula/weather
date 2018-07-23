//
//  City.swift
//  weather
//
//  Created by Wagner De Paula on 7/21/18.
//

import Foundation

struct Location: Codable {
    let title: String
    let location_type: String
    let woeid: Int
    let latt_long: String
    let consolidated_weather: [Day]?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case location_type
        case woeid
        case latt_long
        case consolidated_weather
    }
}


struct Day: Codable {
    let weather_state_name: String
    let weather_state_abbr: String
    let applicable_date: String
    let min_temp: Double
    let max_temp: Double
    let the_temp: Double
    let humidity: Int
    
    private enum CodingKeys: String, CodingKey {
        case weather_state_name
        case weather_state_abbr
        case applicable_date
        case min_temp
        case max_temp
        case the_temp
        case humidity
    }
    
}
