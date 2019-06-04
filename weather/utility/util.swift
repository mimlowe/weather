//
//  util.swift
//  weather
//
//  Created by dev on 6/3/19.
//  Copyright © 2019 michaelmlowe. All rights reserved.
//

import Foundation

// Unit Conversions
func KelvintoCelsius(kelvin: Double) -> Double {
    let celsiusTemp = kelvin - 273.15
    return celsiusTemp
}

func KelvintoFahrenheit(kelvin: Double) -> Double {
    let fahrenheitTemp = 1.8*(kelvin - 273) + 32
    return fahrenheitTemp
}

// Degrees -> Radians
func deg2rad(_ number: Double) -> Double {
    return number * .pi / 180
}
