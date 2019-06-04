//
//  DetailViewController.swift
//  weather
//
//  Created by dev on 6/3/19.
//  Copyright © 2019 michaelmlowe. All rights reserved.
//

import UIKit
import CoreLocation

class DetailViewController: UIViewController {
    

    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var tempLabel: UILabel?
    @IBOutlet weak var windLabel: UILabel?
    @IBOutlet weak var iconImage: UIImageView?

    public var city: City?
    var presentor:ViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.city?.name
        let iconSuffix = (self.city?.img)!
        var temp_f = KelvintoFahrenheit(kelvin: (self.city?.temp_report.temp)!)
        temp_f = temp_f.rounded()
        let url = "http://openweathermap.org/img/w/"+iconSuffix+".png"
        self.tempLabel?.text = "\(temp_f)ºF"
        self.iconImage?.downloaded(from: url)
        let speed = (self.city?.wind_report.speed)!
        let deg = (self.city?.wind_report.deg)!
        self.windLabel?.text = "\(speed), \(deg)º"
    }
 
}


