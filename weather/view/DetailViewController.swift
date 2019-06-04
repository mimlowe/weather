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

    @IBOutlet weak var tempLabel         : UILabel?
    @IBOutlet weak var windLabel         : UILabel?
    @IBOutlet weak var iconImage         : UIImageView?
    @IBOutlet weak var compass           : UIImageView?
    
    // A single City object for detailed view
    public var city: City?
    var presentor:ViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.city?.name
        
        // Temperature setup
        var temp_f = KelvintoFahrenheit(kelvin: (self.city?.temp_report.temp)!)
        temp_f = temp_f.rounded()
        // Display the temperature without decimal
        let temp_i = Int(temp_f)
        self.tempLabel?.text = "\(temp_i)ºF"
        
        // Icon Setup
        let iconSuffix = (self.city?.img)!
        let url = "http://openweathermap.org/img/w/"+iconSuffix+".png"
        self.iconImage?.downloaded(from: url)
        
        // Wind Setup
        let deg = (self.city?.wind_report.deg)!
        let speed = (self.city?.wind_report.speed)!
        self.windLabel?.text = "\(speed) m/s"
        
        // Wind Compass Setup
        var compassImage = self.compass?.image
        let rad = deg2rad(deg)
        compassImage = compassImage?.rotate(radians: Float(rad))
        self.compass?.image = compassImage
    }
 
}


