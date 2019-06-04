//
//  Report.swift
//  weather
//
//  Created by dev on 6/3/19.
//  Copyright © 2019 michaelmlowe. All rights reserved.
//
import Foundation

// Top Level JSON Object
public struct City {
    public let name: String
    public let img: String
    public let id: Int
    public let temp_report: TemperatureReport
    public let wind_report: WindReport
    public let isCurrentCity: Bool
    
    public init(name: String, img: String, id: Int, temp_report: TemperatureReport, wind_report: WindReport, is_current_city: Bool){
        self.name = name
        self.img = img
        self.id = id
        self.temp_report = temp_report
        self.wind_report = wind_report
        self.isCurrentCity = is_current_city
        
    }
}

// Temperature Nested JSON Object
public struct TemperatureReport {
    public let temp: Double
    public let temp_min: Double
    public let temp_max: Double
    
    public init(temp: Double, temp_min: Double, temp_max: Double) {
        self.temp = temp
        self.temp_min = temp_min
        self.temp_max = temp_max
    }
}

// Wind Nested JSON Object
public struct WindReport {
    public let speed: Double
    public let deg: Double 

    public init(speed: Double, deg: Double) {
        self.speed = speed
        self.deg = deg
    }
}

