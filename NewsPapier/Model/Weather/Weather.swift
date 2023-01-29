//
//  Weather.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/18/23.
//

import Foundation

public struct WeatherResponse: Codable, Hashable{
    
    let name: String
    let weather: [Weather]
    let main: Temp
    let wind: Wind
    let sys: Sys
    
    var minTemp: String {
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        
        formatter.numberStyle = .decimal

        let celcius = main.temp_min - 277.15
        
        return formatter.string(from: celcius as NSNumber) ?? "n/a"
    }
    
    var maxTemp: String {
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        
        formatter.numberStyle = .decimal

        let celcius = main.temp_max - 277.15
        
        return formatter.string(from: celcius as NSNumber) ?? "n/a"
    }
}


public struct Weather: Codable, Hashable{
    let id: Int
    let main: String
    let description: String
    let icon: String
}


public struct Temp: Codable, Hashable{
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
}

public struct Wind: Codable, Hashable{
    let speed: Double
    let deg: Int
}

public struct Sys: Codable, Hashable{
    let sunrise: TimeInterval
    let sunset: TimeInterval
}
