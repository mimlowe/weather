//
//  WeatherInteractor.swift
//  weather
//
//  Created by dev on 6/3/19.
//  Copyright © 2019 michaelmlowe. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

class WeatherInteractor: PresenterToInteractorProtocol{
    var presenter: InteractorToPresenterProtocol?
    
    func fetchTokyo() {
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?q=tokyo&appid=78186aead57515b8409525c9b9d682ff").responseJSON { response in
            if(response.response?.statusCode == 200){
                if let json = response.result.value as AnyObject? {
                    let id = json["id"] as? Int
                    let name = json["name"] as? String
                    
                    let weather = json["weather"] as? [[String:Any]]
                    let img = weather?[0]["icon"] as? String
                    
                    let temp_report = json["main"] as? [String: Any]
                    let temp = temp_report?["temp"] as? Double
                    let temp_min = temp_report?["temp_min"] as? Double
                    let temp_max = temp_report?["temp_max"] as? Double
                    
                    let wind_report = json["wind"] as? [String: Any]
                    let speed = wind_report?["speed"] as? Double
                    let deg = wind_report?["deg"] as? Double
                    
                    let tempReport = TemperatureReport(temp: temp!, temp_min: temp_min!, temp_max: temp_max!)
                    let windReport = WindReport(speed: speed!, deg: deg!)
                    let model = City(name: name!, img: img!, id: id!, temp_report: tempReport, wind_report: windReport, is_current_city: false)
                    self.presenter?.cityFetchedSuccess(city: model)
                }
            } else {
                self.presenter?.cityFetchFailed()
            }
        }
    }
    
    func fetchLondon() {
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?q=london&appid=78186aead57515b8409525c9b9d682ff").responseJSON { response in
            if(response.response?.statusCode == 200){
                if let json = response.result.value as AnyObject? {
                    let id = json["id"] as? Int
                    let name = json["name"] as? String
                    
                    let weather = json["weather"] as? [[String:Any]]
                    let img = weather?[0]["icon"] as? String
                    
                    let temp_report = json["main"] as? [String: Any]
                    let temp = temp_report?["temp"] as? Double
                    let temp_min = temp_report?["temp_min"] as? Double
                    let temp_max = temp_report?["temp_max"] as? Double
                    
                    let wind_report = json["wind"] as? [String: Any]
                    let speed = wind_report?["speed"] as? Double
                    let deg = wind_report?["deg"] as? Double
                    
                    let tempReport = TemperatureReport(temp: temp!, temp_min: temp_min!, temp_max: temp_max!)
                    let windReport = WindReport(speed: speed!, deg: deg!)
                    let model = City(name: name!, img: img!, id: id!, temp_report: tempReport, wind_report: windReport, is_current_city: false)
                    self.presenter?.cityFetchedSuccess(city: model)
                }
            } else {
                self.presenter?.cityFetchFailed()
            }
        }
    }
    
    func fetchCurrentCity(loc: CLLocationCoordinate2D) {
        
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?lat=\(loc.latitude)&lon=\(loc.longitude)&appid=78186aead57515b8409525c9b9d682ff").responseJSON { response in
            if(response.response?.statusCode == 200){
                if let json = response.result.value as AnyObject? {
                    let id = json["id"] as? Int
                    let name = json["name"] as? String
                    
                    let weather = json["weather"] as? [[String:Any]]
                    let img = weather?[0]["icon"] as? String
                    
                    let temp_report = json["main"] as? [String: Any]
                    let temp = temp_report?["temp"] as? Double
                    let temp_min = temp_report?["temp_min"] as? Double
                    let temp_max = temp_report?["temp_max"] as? Double
                    
                    let wind_report = json["wind"] as? [String: Any]
                    let speed = wind_report?["speed"] as? Double
                    let deg = wind_report?["deg"] as? Double
                    
                    let tempReport = TemperatureReport(temp: temp!, temp_min: temp_min!, temp_max: temp_max!)
                    let windReport = WindReport(speed: speed!, deg: deg!)
                    let model = City(name: name!, img: img!, id: id!, temp_report: tempReport, wind_report: windReport, is_current_city: true)
                    self.presenter?.cityFetchedSuccess(city: model)
                }
            }else {
                self.presenter?.cityFetchFailed()
            }
        }
    }
}
