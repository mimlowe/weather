//
//  WeatherInteractor.swift
//  weather
//
//  Created by dev on 6/3/19.
//  Copyright © 2019 michaelmlowe. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class WeatherInteractor: PresenterToInteractorProtocol{
    var presenter: InteractorToPresenterProtocol?
    
    func fetchCity() {
        Alamofire.request("https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22").responseJSON { response in
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
                    let model = City(name: name!, img: img!, id: id!, temp_report: tempReport, wind_report: windReport)
                    self.presenter?.cityFetchedSuccess(city: model)
                }
            }else {
                self.presenter?.cityFetchFailed()
            }
        }
    }
}
